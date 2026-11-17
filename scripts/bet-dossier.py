#!/usr/bin/env python3
"""bet-dossier: lay out everything a bet rests on, in date order.

Usage: scripts/bet-dossier.py <note.md> [--write]

Reads the note's frontmatter `evidence:` list and its `[[notes/...]]` links,
then prints one markdown dossier:

  - a timeline (note made, each transcript turn, each change of the cited
    file lines, each related note), sorted by date;
  - transcript extracts: the cited turn and the turn before it;
  - line history: `git log -L` of the cited section/lines in the project;
  - related notes: status, made, first claim line.

Evidence item grammar (one per list entry, YAML comment allowed after it):
  transcripts/<slug>/<sid>/main.jsonl#<uuid>        exact record
  transcripts/<slug>/<sid>/subagents/<f>.jsonl#<uuid>
  transcripts/<slug>/<sid>/<f>.jsonl                record found by the first
                                                   "quoted phrase" in the comment
  knowledge/<file>.md#<heading-slug>                section history
  knowledge/<file>.md:<line>[-<line>]               line history
  knowledge/<file>.md                               file history
  (any path under the project repo works, not only knowledge/)

Transcripts are read from $SLEEP_HOME/tx/<slug>/, the project from
$SLEEP_HOME/work/<slug> (fetched, never checked out: history is read from
origin/main). Nothing is written unless --write, which puts the dossier
under `## Dossier` at the end of the note, replacing an earlier one.
"""
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timezone

SLEEP_HOME = os.path.expanduser(os.environ.get("SLEEP_HOME", "~/.ai-lab-sleep"))
USER = os.path.join(SLEEP_HOME, "user")
EXTRACT_CHARS = 700


def die(msg):
    sys.stderr.write(f"bet-dossier: {msg}\n")
    sys.exit(1)


def read_frontmatter(text):
    if not text.startswith("---\n"):
        return {}, text
    end = text.find("\n---\n", 4)
    if end < 0:
        return {}, text
    fm, body = text[4:end], text[end + 5:]
    data, key = {}, None
    for line in fm.splitlines():
        m = re.match(r"^([A-Za-z_]+):\s*(.*)$", line)
        if m:
            key, val = m.group(1), m.group(2)
            data[key] = val if val != "" else []
            continue
        m = re.match(r"^\s+-\s+(.*)$", line)
        if m and key is not None:
            if not isinstance(data[key], list):
                data[key] = []
            data[key].append(m.group(1))
    return data, body


def split_item(raw):
    """'path#frag  # comment' -> (path, frag, comment)"""
    comment = ""
    m = re.match(r"^(.*?)\s+#\s*(.*)$", raw)
    if m:
        raw, comment = m.group(1), m.group(2)
    raw = raw.strip()
    frag = None
    if "#" in raw:
        raw, frag = raw.split("#", 1)
    else:
        m = re.match(r"^(.*?):(\d+(?:-\d+)?)$", raw)
        if m:
            raw, frag = m.group(1), m.group(2)
    return raw, frag, comment


def parse_ts(s):
    if not s:
        return None
    s = s.strip()
    for fmt in ("%Y-%m-%dT%H:%M:%S.%fZ", "%Y-%m-%dT%H:%M:%SZ", "%Y-%m-%dT%H:%M:%S",
                "%Y-%m-%d", "%Y-%m"):
        try:
            return datetime.strptime(s, fmt).replace(tzinfo=timezone.utc)
        except ValueError:
            pass
    return None


def record_text(rec, limit=EXTRACT_CHARS):
    msg = rec.get("message") or {}
    content = msg.get("content")
    if isinstance(content, str):
        parts = [content]
    else:
        parts = []
        for b in content or []:
            t = b.get("type")
            if t == "text":
                parts.append(b.get("text", ""))
            elif t == "tool_use":
                parts.append(f"[tool_use {b.get('name')}]")
            elif t == "tool_result":
                c = b.get("content")
                if isinstance(c, list):
                    c = " ".join(x.get("text", "") for x in c if isinstance(x, dict))
                parts.append(f"[tool_result] {str(c or '')}")
    text = "\n".join(p for p in parts if p).strip()
    if limit and len(text) > limit:
        text = text[:limit] + " …"
    return text


def load_jsonl(path):
    recs = []
    with open(path, encoding="utf-8", errors="replace") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                recs.append(json.loads(line))
            except json.JSONDecodeError:
                continue
    return recs


def find_record(recs, uuid, phrase):
    by_id = {r.get("uuid"): r for r in recs if r.get("uuid")}
    if uuid and uuid in by_id:
        return by_id[uuid], by_id, "uuid"
    if phrase:
        # "a ... b" matches a record containing every fragment
        needles = [re.sub(r"\W+", " ", p).strip().lower()
                   for p in re.split(r"\.\.\.|…", phrase)]
        needles = [n for n in needles if n]
        for r in recs:
            hay = re.sub(r"\W+", " ", record_text(r, limit=0)).lower()
            if needles and all(n in hay for n in needles):
                return r, by_id, f'phrase "{phrase}"'
    return None, by_id, None


def git(cwd, *args):
    return subprocess.run(["git", "-C", cwd, *args], capture_output=True, text=True)


def project_dir(slug):
    d = os.path.join(SLEEP_HOME, "work", slug)
    if not os.path.isdir(os.path.join(d, ".git")):
        remote = None
        try:
            with open(os.path.join(USER, "projects.yaml")) as f:
                y = f.read()
            m = re.search(rf"slug:\s*{re.escape(slug)}\s*\n\s*remote:\s*(\S+)", y)
            if m:
                remote = m.group(1)
        except OSError:
            pass
        if not remote:
            return None, f"no clone at {d} and no remote in projects.yaml"
        os.makedirs(os.path.dirname(d), exist_ok=True)
        r = subprocess.run(["git", "clone", "-q", remote, d], capture_output=True, text=True)
        if r.returncode:
            return None, f"clone failed: {r.stderr.strip()}"
    git(d, "fetch", "-q", "origin", "main")
    return d, None


def heading_slug(s):
    return re.sub(r"[^a-z0-9]+", "-", s.lower()).strip("-")


def section_range(lines, frag):
    """Return (start,end) 1-based for heading slug `frag`, or None."""
    for i, line in enumerate(lines):
        m = re.match(r"^(#+)\s+(.*)$", line)
        if m and heading_slug(m.group(2)) == heading_slug(frag):
            level = len(m.group(1))
            end = len(lines)
            for j in range(i + 1, len(lines)):
                m2 = re.match(r"^(#+)\s", lines[j])
                if m2 and len(m2.group(1)) <= level:
                    end = j
                    break
            return i + 1, end
    return None


def line_history(pdir, path, frag):
    show = git(pdir, "show", f"origin/main:{path}")
    if show.returncode:
        return None, [], f"{path}: not in origin/main"
    lines = show.stdout.splitlines()
    rng, label = None, path
    if frag is not None:
        if re.match(r"^\d+(-\d+)?$", frag):
            a, _, b = frag.partition("-")
            rng = (int(a), int(b or a))
            label = f"{path}:{frag}"
        else:
            rng = section_range(lines, frag)
            label = f"{path}#{frag}"
            if rng is None:
                return None, [], f"{label}: heading not found in origin/main"
    args = ["log", "--date=short", "--format=@@ %h %ad %an: %s"]
    if rng:
        args.append(f"-L{rng[0]},{rng[1]}:{path}")
        args.append("origin/main")
    else:
        args += ["origin/main", "--", path]
    log = git(pdir, *args)
    if log.returncode:
        return None, [], f"{label}: {log.stderr.strip()}"
    events = []
    for m in re.finditer(r"^@@ ([0-9a-f]+) (\d{4}-\d{2}-\d{2}) (.*)$", log.stdout, re.M):
        events.append((parse_ts(m.group(2)), f"`{path}` changed in {m.group(1)}: {m.group(3)}"))
    current = "\n".join(lines[rng[0] - 1:rng[1]]) if rng else None
    return (label, log.stdout.strip(), current), events, None


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    write = "--write" in sys.argv
    if not args:
        die(__doc__.strip())
    note_path = os.path.abspath(args[0])
    with open(note_path, encoding="utf-8") as f:
        original = f.read()
    fm, body = read_frontmatter(original)
    body_wo = re.split(r"\n## Dossier\n", body, maxsplit=1)[0].rstrip() + "\n"

    slug = fm.get("project") if isinstance(fm.get("project"), str) else None
    if not slug:
        m = re.search(r"/agent-memory/_main/([^/]+)/", note_path)
        slug = m.group(1) if m else None

    made = parse_ts(fm.get("made") if isinstance(fm.get("made"), str) else None)
    timeline, extracts, histories, related, problems = [], [], [], [], []
    if made:
        timeline.append((made, f"note made ({fm.get('origin', '?')}): `{os.path.relpath(note_path, USER)}`"))

    for raw in fm.get("evidence") or []:
        path, frag, comment = split_item(raw)
        phrase = None
        m = re.search(r'"([^"]{6,})"', comment)
        if m:
            phrase = m.group(1)
        if path.startswith("transcripts/"):
            parts = path.split("/")
            if len(parts) < 4:
                problems.append(f"{raw}: unparseable transcript path")
                continue
            tslug, rest = parts[1], "/".join(parts[2:])
            fpath = os.path.join(SLEEP_HOME, "tx", tslug, rest)
            if not os.path.isfile(fpath):
                problems.append(f"{path}: not found under $SLEEP_HOME/tx (fetch sleep/transcripts first)")
                continue
            recs = load_jsonl(fpath)
            rec, by_id, how = find_record(recs, frag, phrase)
            if rec is None:
                problems.append(f"{path}: no record for #{frag or '?'}"
                                + (f' or phrase "{phrase}"' if phrase else "; add #<uuid> or a \"quoted phrase\" in the comment"))
                continue
            parent = by_id.get(rec.get("parentUuid"))
            ts = parse_ts(rec.get("timestamp"))
            sid = parts[2][:8]
            timeline.append((ts, f"turn in `{tslug}/{sid}…/{parts[-1]}` ({rec.get('type')}): {record_text(rec)[:90].replace(chr(10), ' ')}"))
            extracts.append((path, rec, parent, how))
        else:
            if not slug:
                problems.append(f"{path}: note has no project, cannot read history")
                continue
            pdir, err = project_dir(slug)
            if err:
                problems.append(err)
                continue
            hist, events, err = line_history(pdir, path, frag)
            if err:
                problems.append(err)
                continue
            histories.append(hist)
            timeline.extend(events)

    for link in sorted(set(re.findall(r"\[\[(notes/[^\]|#]+)\]\]", body_wo))):
        rp = os.path.join(os.path.dirname(os.path.dirname(note_path)), link + ".md")
        if not os.path.isfile(rp):
            problems.append(f"[[{link}]]: file not found beside this note")
            continue
        with open(rp, encoding="utf-8") as f:
            rfm, rbody = read_frontmatter(f.read())
        claim = next((l.strip() for l in rbody.splitlines() if l.strip()), "")
        rmade = parse_ts(rfm.get("made") if isinstance(rfm.get("made"), str) else None)
        related.append((link, rfm.get("status", "?"), rfm.get("origin", "?"), rfm.get("made", "?"), claim))
        timeline.append((rmade, f"related note made ({rfm.get('status', '?')}): [[{link}]] — {claim[:90]}"))

    out = []
    out.append(f"## Dossier\n")
    out.append(f"_generated {datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%MZ')} by scripts/bet-dossier.py; "
               f"status {fm.get('status', '?')}, origin {fm.get('origin', '?')}, project {slug or '?'}_\n")
    out.append("### Timeline\n")
    undated = [e for e in timeline if e[0] is None]
    for ts, text in sorted((e for e in timeline if e[0] is not None), key=lambda e: e[0]):
        out.append(f"- {ts.strftime('%Y-%m-%d %H:%M')}  {text}")
    for _, text in undated:
        out.append(f"- (undated)        {text}")
    if extracts:
        out.append("\n### Transcript extracts\n")
        for path, rec, parent, how in extracts:
            out.append(f"**{path}** (found by {how})\n")
            if parent:
                out.append(f"> _{parent.get('type')} · {parent.get('timestamp', '')} · {parent.get('uuid', '')}_  \n> "
                           + record_text(parent).replace("\n", "\n> ") + "\n")
            out.append(f"> _{rec.get('type')} · {rec.get('timestamp', '')} · {rec.get('uuid', '')}_  \n> "
                       + record_text(rec).replace("\n", "\n> ") + "\n")
    if histories:
        out.append("### Line history (origin/main)\n")
        for label, log, current in histories:
            out.append(f"**{label}**")
            if current is not None:
                out.append("\nCurrent text:\n")
                out.append("```\n" + current + "\n```")
            out.append("\nHistory:\n")
            out.append("```\n" + (log or "(no commits touch these lines)") + "\n```\n")
    if related:
        out.append("### Related notes\n")
        for link, st, org, md, claim in related:
            out.append(f"- [[{link}]] — {st}, {org}, made {md}: {claim}")
    if problems:
        out.append("\n### Could not resolve\n")
        for p in problems:
            out.append(f"- {p}")
    dossier = "\n".join(out).rstrip() + "\n"

    if write:
        head = original[: len(original) - len(body)] if original.startswith("---\n") else ""
        with open(note_path, "w", encoding="utf-8") as f:
            f.write(head + body_wo + "\n" + dossier)
        print(f"dossier written into {note_path}")
    else:
        print(dossier, end="")


if __name__ == "__main__":
    main()

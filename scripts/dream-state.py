#!/usr/bin/env python3
"""dream-state.py — read and update dream-state.json without inline Python.

Usage (run from the user clone):
  scripts/dream-state.py show
  scripts/dream-state.py new <dir>...          list files under <dir> (tx clones) not yet consumed
  scripts/dream-state.py settled [--consumed PATH ...] [--project SLUG=SHA ...]
        sets last_settled = now (UTC, seconds), appends the given consumed
        paths (deduplicated, order kept) and records each project's main sha.
        PATH is relative to $SLEEP_HOME: tx/<slug>/<session>/main.jsonl,
        tx/<slug>/<session>/subagents/<file>.jsonl, tx/<slug>/<session>/memory-outbox.

The file keeps exactly three keys: last_settled, consumed, project_main.
"""
import json
import os
import sys
from datetime import datetime, timezone

SLEEP_HOME = os.path.expanduser(os.environ.get("SLEEP_HOME", "~/.ai-lab-sleep"))
PATH = "dream-state.json"


def load():
    try:
        with open(PATH, encoding="utf-8") as f:
            d = json.load(f)
    except FileNotFoundError:
        d = {}
    return {"last_settled": d.get("last_settled", ""),
            "consumed": list(d.get("consumed", [])),
            "project_main": dict(d.get("project_main", {}))}


def save(d):
    with open(PATH, "w", encoding="utf-8") as f:
        json.dump(d, f, indent=2)
        f.write("\n")


def main(argv):
    if not argv or argv[0] in ("-h", "--help"):
        print(__doc__.strip()); return 0
    cmd, args = argv[0], argv[1:]
    d = load()
    if cmd == "show":
        print(json.dumps({"last_settled": d["last_settled"], "consumed": len(d["consumed"]),
                          "project_main": d["project_main"]}, indent=2))
        return 0
    if cmd == "new":
        seen = set(d["consumed"])
        for root in args:
            root = root.rstrip("/")
            for dp, dns, fns in os.walk(root):
                if "/.git" in dp or dp.endswith("/.git"):
                    continue
                rel_dir = os.path.relpath(dp, SLEEP_HOME)
                if os.path.basename(dp) == "memory-outbox":
                    if rel_dir not in seen:
                        print(rel_dir)
                    dns[:] = []
                    continue
                for fn in fns:
                    if fn.endswith(".jsonl"):
                        rel = os.path.relpath(os.path.join(dp, fn), SLEEP_HOME)
                        if rel not in seen:
                            print(rel)
        return 0
    if cmd == "settled":
        consumed, projects, mode = [], [], None
        for a in args:
            if a == "--consumed":
                mode = "c"; continue
            if a == "--project":
                mode = "p"; continue
            if mode == "c":
                consumed.append(a)
            elif mode == "p":
                projects.append(a)
            else:
                sys.stderr.write(f"unexpected argument {a}\n"); return 2
        d["last_settled"] = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
        seen = set(d["consumed"])
        for c in consumed:
            c = c.replace(SLEEP_HOME + "/", "")
            if c not in seen:
                d["consumed"].append(c); seen.add(c)
        for p in projects:
            slug, _, sha = p.partition("=")
            if slug and sha:
                d["project_main"][slug] = sha
        save(d)
        print(f"last_settled {d['last_settled']}, consumed {len(d['consumed'])}, projects {d['project_main']}")
        return 0
    sys.stderr.write(f"unknown command {cmd}\n"); return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))

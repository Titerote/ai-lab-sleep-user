#!/usr/bin/env bash
# Ship the current session's transcripts (main + subagents) and probe logs to
# the transcripts repo, filed by project and session. Idempotent; pushes with
# a time debounce for per-turn events. Reads the hook input on stdin.
#
# Env: SLEEP_HOME (default ~/.ai-lab-sleep), SHIP_DELAY seconds to wait before
# reading the transcript (default 0; the Stop hook passes 6 so the file has
# flushed), SHIP_DEBOUNCE seconds between pushes for Stop/UserPromptSubmit
# (default 600).
set -u
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
T="$SLEEP_HOME/transcripts"
LOG="$SLEEP_HOME/ship.log"
DELAY="${SHIP_DELAY:-0}"
DEBOUNCE="${SHIP_DEBOUNCE:-600}"
mkdir -p "$SLEEP_HOME"
log() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" >>"$LOG"; }

input="$(cat)"
[ "$DELAY" -gt 0 ] && sleep "$DELAY"

# Parse the hook input once.
eval "$(python3 - <<'PY' "$input"
import json, sys, shlex
try:
    d = json.loads(sys.argv[1]) if sys.argv[1].strip() else {}
except Exception:
    d = {}
for k in ("hook_event_name", "session_id", "transcript_path", "agent_transcript_path", "cwd"):
    print(f"{k}={shlex.quote(str(d.get(k) or ''))}")
PY
)"
event="${hook_event_name:-unknown}"
cwd="${cwd:-$PWD}"
sid="${session_id:-unknown}"
tp="${transcript_path/#\~/$HOME}"
atp="${agent_transcript_path/#\~/$HOME}"

[ -d "$T/.git" ] || { log "no transcripts clone at $T; run bootstrap"; exit 0; }

# Project slug from the git remote, else the directory name.
slug="$(git -C "$cwd" remote get-url origin 2>/dev/null | sed -E 's#.*[/:]##; s#\.git$##')"
[ -n "$slug" ] || slug="$(basename "$cwd")"
dest="$T/$slug/$sid"
state="$SLEEP_HOME/state/$slug/$sid"      # locks and stamps, outside the repo
mkdir -p "$dest/subagents" "$dest/probe" "$state"

# Serialize concurrent hooks on one session (portable lock, no flock on macOS).
lock="$state/lock"
for _ in $(seq 1 50); do mkdir "$lock" 2>/dev/null && break; sleep 0.2; done
trap 'rmdir "$lock" 2>/dev/null' EXIT

# Copy what exists. The subagents folder sits beside the main transcript,
# in a directory named after the session id.
[ -f "$tp" ] && cp "$tp" "$dest/main.jsonl"
sa="$(dirname "$tp")/$sid/subagents"
[ -d "$sa" ] && cp "$sa"/* "$dest/subagents/" 2>/dev/null
[ -f "$atp" ] && cp "$atp" "$dest/subagents/" 2>/dev/null
[ -d "$cwd/probe" ] && cp "$cwd/probe"/*.jsonl "$dest/probe/" 2>/dev/null

# Content unchanged → nothing to commit (checked before touching the
# manifest, whose timestamp would otherwise make every event a commit), but a
# debounced commit may still be waiting to be pushed.
git -C "$T" add -A "$slug/$sid" >/dev/null 2>&1
if git -C "$T" diff --cached --quiet; then
  changed=0
else
  changed=1
  python3 - "$dest/manifest.json" "$slug" "$sid" "$cwd" "$event" <<'PY'
import json, os, sys, subprocess, datetime, socket
path, slug, sid, cwd, event = sys.argv[1:6]
def git(*a):
    try: return subprocess.check_output(["git","-C",cwd,*a], text=True, stderr=subprocess.DEVNULL).strip()
    except Exception: return None
m = {}
if os.path.exists(path):
    try: m = json.load(open(path))
    except Exception: m = {}
m.update({
    "project": slug, "session_id": sid, "cwd": cwd,
    "remote": git("remote","get-url","origin"), "commit": git("rev-parse","HEAD"),
    "branch": git("rev-parse","--abbrev-ref","HEAD"),
    "claude_code_remote": os.environ.get("CLAUDE_CODE_REMOTE"), "host": socket.gethostname(),
    "last_event": event,
    "last_shipped": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds"),
})
m.setdefault("first_shipped", m["last_shipped"])
json.dump(m, open(path,"w"), indent=2)
PY
  git -C "$T" add -A "$slug/$sid" >/dev/null 2>&1
  git -C "$T" -c user.name=ship -c user.email=ship@ai-lab commit -q -m "ship: $slug $sid ($event)" || { log "commit failed"; exit 0; }
fi

# Memory written by auto memory in the user clone goes straight to main too
# (agent-memory/ only; agents, scripts and proposals keep the PR flow) — but
# only when a unit of work has ended: a subagent run, the session, or the
# catch-up on resume. Per-turn events ship transcripts only.
U="$SLEEP_HOME/user"
case "$event" in SubagentStop|SessionEnd|SessionStart) ship_mem=1;; *) ship_mem=0;; esac
if [ "$ship_mem" = 1 ] && [ -d "$U/.git" ]; then
  git -C "$U" add -A agent-memory >/dev/null 2>&1
  if ! git -C "$U" diff --cached --quiet; then
    git -C "$U" -c user.name=ship -c user.email=ship@ai-lab commit -q -m "memory: $slug $sid ($event)" && changed=1
  fi
fi

# Anything committed but not yet on origin/main, in either repo?
pending=0
for R in "$T" "$U"; do
  [ -d "$R/.git" ] || continue
  n=$(git -C "$R" rev-list --count origin/main..HEAD 2>/dev/null || echo 1); pending=$((pending + n))
done
if [ "$pending" -eq 0 ]; then log "$slug/$sid $event: no change"; exit 0; fi

# Debounce per-turn events; terminal events push now.
stamp="$state/last_push"
now=$(date +%s)
case "$event" in
  Stop|UserPromptSubmit)
    if [ -f "$stamp" ] && [ $((now - $(cat "$stamp"))) -lt "$DEBOUNCE" ]; then
      log "$slug/$sid $event: $([ $changed = 1 ] && echo committed || echo pending), push debounced"; exit 0
    fi;;
esac

push_main() { # <repo dir> → 0 on success
  local R="$1" G="git -C $1 -c user.name=ship -c user.email=ship@ai-lab" i
  for i in 1 2 3; do
    # A rebase left half-done by an earlier failure would wedge every later ship.
    if [ -d "$R/.git/rebase-merge" ] || [ -d "$R/.git/rebase-apply" ]; then
      $G rebase --abort >/dev/null 2>&1 || rm -rf "$R/.git/rebase-merge" "$R/.git/rebase-apply"
    fi
    # --autostash: the user clone may carry uncommitted edits to agents/ or scripts/ (PR flow); leave them alone.
    $G pull -q --rebase --autostash origin main >/dev/null 2>&1 || { $G rebase --abort >/dev/null 2>&1; sleep $((i * 2)); continue; }
    if $G push -q origin HEAD:main >/dev/null 2>&1 && [ "$($G rev-list --count origin/main..HEAD)" = 0 ]; then return 0; fi
    sleep $((i * 2))
  done
  return 1
}

ok=1
for R in "$T" "$U"; do
  [ -d "$R/.git" ] || continue
  [ "$(git -C "$R" rev-list --count origin/main..HEAD 2>/dev/null || echo 1)" = 0 ] && continue
  if push_main "$R"; then log "$slug/$sid $event: pushed $(basename "$R")"; else ok=0; log "$slug/$sid $event: push failed for $(basename "$R") after 3 attempts (left committed)"; fi
done
[ $ok = 1 ] && echo "$now" >"$stamp"
exit 0

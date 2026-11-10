#!/usr/bin/env bash
# Hook probe: append the full hook input, plus where/when it ran, to
# $CLAUDE_PROJECT_DIR/probe/<event>.jsonl. Never fails the hook.
set -u
dir="${CLAUDE_PROJECT_DIR:-$PWD}/probe"
mkdir -p "$dir" 2>/dev/null || exit 0
raw="$(cat)"
PROBE_RAW="$raw" python3 -c '
import json, os, sys, datetime, socket
dir_ = sys.argv[1]
raw = os.environ.get("PROBE_RAW", "")
try:
    data = json.loads(raw) if raw.strip() else {}
except Exception:
    data = {"_unparsed": raw}
event = data.get("hook_event_name", "unknown")
def stat(p):
    if not p: return None
    p = os.path.expanduser(p)
    try:
        st = os.stat(p); return {"exists": True, "bytes": st.st_size, "mtime": datetime.datetime.fromtimestamp(st.st_mtime, datetime.timezone.utc).isoformat(timespec="seconds")}
    except FileNotFoundError:
        return {"exists": False, "parent_exists": os.path.isdir(os.path.dirname(p))}
rec = {
    "files": {"transcript_path": stat(data.get("transcript_path")), "agent_transcript_path": stat(data.get("agent_transcript_path"))},
    "ts": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds"),
    "event": event,
    "remote": os.environ.get("CLAUDE_CODE_REMOTE"),
    "host": socket.gethostname(),
    "pwd": os.getcwd(),
    "input": data,
}
with open(os.path.join(dir_, f"{event}.jsonl"), "a") as f:
    f.write(json.dumps(rec) + "\n")
' "$dir" 2>/dev/null
exit 0

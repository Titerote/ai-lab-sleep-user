#!/usr/bin/env bash
# Ship the current session's transcripts (main + subagents) and probe logs to
# an orphan branch of the PROJECT's own repo (default: sleep/transcripts).
# The branch never merges into main; the dreamer fetches it per project.
# Why the project repo: a cloud VM can push only to repos attached to the
# session, and attaching several repos disables the repo's hooks.
#
# Also ships agent-memory/ of the user clone when a unit of work ends
# (SubagentStop, SessionEnd, SessionStart catch-up): on the Mac straight to
# the user repo's main; in the cloud, where only the project repo is
# pushable, as a memory-outbox/ on the transcripts branch that the next
# settle phase applies into the user repo.
#
# Reads the hook input on stdin. Idempotent; per-turn events push with a time
# debounce, terminal events flush.
#
# Env: SLEEP_HOME (default ~/.ai-lab-sleep), SLEEP_TX_BRANCH (default
# sleep/transcripts), SHIP_DELAY seconds to wait before reading the transcript
# (default 0), SHIP_DEBOUNCE seconds between pushes for Stop/UserPromptSubmit
# (default 600).
set -u
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
BRANCH="${SLEEP_TX_BRANCH:-sleep/transcripts}"
LOG="$SLEEP_HOME/ship.log"
DELAY="${SHIP_DELAY:-0}"
DEBOUNCE="${SHIP_DEBOUNCE:-600}"
mkdir -p "$SLEEP_HOME"
log() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" >>"$LOG"; }
G() { git -C "$1" -c user.name=ship -c user.email=ship@ai-lab "${@:2}"; }

input="$(cat)"
[ "$DELAY" -gt 0 ] && sleep "$DELAY"

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

remote="$(git -C "$cwd" remote get-url origin 2>/dev/null)"
[ -n "$remote" ] || { log "$sid $event: cwd $cwd has no origin; nothing shipped"; exit 0; }
slug="$(printf '%s' "$remote" | sed -E 's#.*[/:]##; s#\.git$##')"
T="$SLEEP_HOME/tx/$slug"           # clone of the project's transcript branch
state="$SLEEP_HOME/state/$slug/$sid"
mkdir -p "$state" "$SLEEP_HOME/tx"

# One clone per project, on the orphan branch; created from the remote branch
# if it exists, else as a fresh orphan with the same origin.
if [ ! -d "$T/.git" ]; then
  if ! git clone -q --single-branch --branch "$BRANCH" "$remote" "$T" 2>/dev/null; then
    rm -rf "$T"; git init -q "$T"; git -C "$T" remote add origin "$remote"
    git -C "$T" checkout -q --orphan "$BRANCH"
    printf '# %s transcripts\n\nOrphan branch written by ship.sh; never merge into main.\n' "$slug" >"$T/README.md"
    G "$T" add README.md; G "$T" commit -q -m "ship: init $BRANCH"
  fi
fi
dest="$T/$sid"
mkdir -p "$dest/subagents" "$dest/probe"

# Serialize concurrent hooks on one session (portable lock, no flock on macOS).
lock="$state/lock"
for _ in $(seq 1 50); do mkdir "$lock" 2>/dev/null && break; sleep 0.2; done
trap 'rmdir "$lock" 2>/dev/null' EXIT

[ -f "$tp" ] && cp "$tp" "$dest/main.jsonl"
sa="$(dirname "$tp")/$sid/subagents"
[ -d "$sa" ] && cp "$sa"/* "$dest/subagents/" 2>/dev/null
[ -f "$atp" ] && cp "$atp" "$dest/subagents/" 2>/dev/null
[ -d "$cwd/probe" ] && cp "$cwd/probe"/*.jsonl "$dest/probe/" 2>/dev/null

changed=0
git -C "$T" add -A "$sid" >/dev/null 2>&1
if ! git -C "$T" diff --cached --quiet; then
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
m.update({"project": slug, "session_id": sid, "cwd": cwd,
          "remote": git("remote","get-url","origin"), "commit": git("rev-parse","HEAD"),
          "branch": git("rev-parse","--abbrev-ref","HEAD"),
          "claude_code_remote": os.environ.get("CLAUDE_CODE_REMOTE"), "host": socket.gethostname(),
          "last_event": event,
          "last_shipped": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds")})
m.setdefault("first_shipped", m["last_shipped"])
json.dump(m, open(path,"w"), indent=2)
PY
  git -C "$T" add -A "$sid" >/dev/null 2>&1
  G "$T" commit -q -m "ship: $slug $sid ($event)" && changed=1
fi

# Memory: agent-memory/ of the user clone, only at the end of a unit of work.
# Where the user repo is writable (the Mac) it is committed and pushed below.
# Where it is not (cloud VMs push only to the attached project repo), the
# session's memory writes travel as an outbox on the transcripts branch:
# memory-outbox/<path under agent-memory/>, applied into the user repo by the
# next settle phase. The user clone is pulled fresh at SessionStart, so its
# working-tree changes are exactly this VM's writes.
U="$SLEEP_HOME/user"
case "$event" in SubagentStop|SessionEnd|SessionStart) ship_mem=1;; *) ship_mem=0;; esac
if [ "$ship_mem" = 1 ] && [ -d "$U/.git" ]; then
  if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ]; then
    git -C "$U" status --porcelain -uall -- agent-memory 2>/dev/null | while read -r st p; do
      case "$st" in D) continue;; esac           # deletions are not carried; settle sees them in the transcript
      [ -f "$U/$p" ] || continue
      mkdir -p "$dest/memory-outbox/$(dirname "$p")"
      cp "$U/$p" "$dest/memory-outbox/$p"
    done
    git -C "$T" add -A "$sid/memory-outbox" >/dev/null 2>&1
    git -C "$T" diff --cached --quiet || { G "$T" commit -q -m "ship: $slug $sid memory outbox ($event)" && changed=1; }
  else
    git -C "$U" add -A agent-memory >/dev/null 2>&1
    git -C "$U" diff --cached --quiet || { G "$U" commit -q -m "memory: $slug $sid ($event)" && changed=1; }
  fi
fi

ahead() { # <repo> <branch> → commits not on origin/<branch> (all, if the remote branch is unknown)
  git -C "$1" rev-list --count "HEAD" "^origin/$2" 2>/dev/null || git -C "$1" rev-list --count HEAD
}
mem_ahead=0; [ -d "$U/.git" ] && mem_ahead=$(ahead "$U" main)
pending=$(( $(ahead "$T" "$BRANCH") + mem_ahead ))
if [ "$pending" -eq 0 ]; then log "$slug/$sid $event: no change"; exit 0; fi

stamp="$state/last_push"; now=$(date +%s)
case "$event" in
  Stop|UserPromptSubmit)
    if [ -f "$stamp" ] && [ $((now - $(cat "$stamp"))) -lt "$DEBOUNCE" ]; then
      log "$slug/$sid $event: $([ $changed = 1 ] && echo committed || echo pending), push debounced"; exit 0
    fi;;
esac

push_branch() { # <repo> <branch> → 0 on success
  local R="$1" B="$2" i
  for i in 1 2 3; do
    if [ -d "$R/.git/rebase-merge" ] || [ -d "$R/.git/rebase-apply" ]; then
      G "$R" rebase --abort >/dev/null 2>&1 || rm -rf "$R/.git/rebase-merge" "$R/.git/rebase-apply"
    fi
    if git -C "$R" ls-remote --exit-code --heads origin "$B" >/dev/null 2>&1; then
      G "$R" pull -q --rebase --autostash origin "$B" >/dev/null 2>&1 || { G "$R" rebase --abort >/dev/null 2>&1; sleep $((i*2)); continue; }
    fi
    if G "$R" push -q origin "HEAD:refs/heads/$B" >/dev/null 2>&1 && [ "$(ahead "$R" "$B")" = 0 ]; then return 0; fi
    sleep $((i * 2))
  done
  return 1
}

ok=1
[ "$(ahead "$T" "$BRANCH")" = 0 ] || { push_branch "$T" "$BRANCH" && log "$slug/$sid $event: pushed transcripts → $BRANCH" || { ok=0; log "$slug/$sid $event: transcripts push failed (left committed)"; }; }
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ] && [ -d "$U/.git" ] && [ "$(ahead "$U" main)" != 0 ]; then
  push_branch "$U" main && log "$slug/$sid $event: pushed memory" || log "$slug/$sid $event: memory push failed (left committed)"
fi
[ $ok = 1 ] && echo "$now" >"$stamp"
exit 0

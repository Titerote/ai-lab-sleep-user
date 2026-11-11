#!/usr/bin/env bash
# PreToolUse guard for dream phases: each phase may write only its layer.
# The phase comes from DREAM_PHASE (CLI: `DREAM_PHASE=settle claude --agent
# dreamer-settle`) or, when that is unset, from a `.dream-phase` file in the
# user clone ($SLEEP_HOME/user, default ~/.ai-lab-sleep/user). No phase →
# no-op. Exit 2 blocks the tool and feeds the message back to the model.
#
# Works from any session folder: paths are resolved against the user clone,
# so the dream can run as subagents of a project session (phone/app) as well
# as whole --agent sessions started in the clone (CLI).
#
# Memory roots: agent-memory/<agent>/ (subagent auto memory) and
# agent-memory/_main/<project>/ (the main session's auto memory, relocated
# with autoMemoryDirectory). Both have the same layers:
#   L1  everything except MEMORY.md and wiki/   (notes/, topic files)
#   L2  wiki/ and issues.md
#   L3  MEMORY.md
set -u
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
U="$SLEEP_HOME/user"
phase="${DREAM_PHASE:-}"
[ -n "$phase" ] || phase="$(tr -d '[:space:]' <"$U/.dream-phase" 2>/dev/null)"
[ -n "$phase" ] || exit 0
input="$(cat)"
path="$(python3 -c 'import json,sys; d=json.loads(sys.argv[1]); print(d.get("tool_input",{}).get("file_path") or d.get("tool_input",{}).get("path") or "")' "$input" 2>/dev/null)"
[ -n "$path" ] || exit 0
case "$path" in /*) ;; *) path="$PWD/$path";; esac
path="$(python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$path")"
Ureal="$(python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$U")"

# Anything outside the user clone is off-limits during a dream (project
# knowledge is read, never written; proposals go in the clone).
case "$path" in "$Ureal"/*) rel="${path#$Ureal/}";; *) echo "Blocked: phase '$phase' may not write outside the user clone ($U): '$path'." >&2; exit 2;; esac

# The phase file itself is always writable (the driving session sets and clears it).
[ "$rel" = ".dream-phase" ] && exit 0

mem='agent-memory/(_main/[^/]+|[^/]+)'
block() { echo "Blocked: phase '$phase' may not write '$rel'. $1 Raise it in issues.md instead." >&2; exit 2; }

case "$phase" in
  settle)
    printf '%s' "$rel" | grep -Eq "^dream-state\.json$" && exit 0
    printf '%s' "$rel" | grep -Eq "^$mem/" || block "Settle writes only inside memory roots."
    printf '%s' "$rel" | grep -Eq "^$mem/(MEMORY\.md|wiki/)" && block "Settle never touches MEMORY.md or wiki/."
    exit 0 ;;
  relate)
    printf '%s' "$rel" | grep -Eq "^$mem/(wiki/.*|issues\.md|dream-log\.md)$" && exit 0
    block "Relate writes only wiki/, issues.md, dream-log.md." ;;
  promote)
    printf '%s' "$rel" | grep -Eq "^($mem/(MEMORY\.md|dream-log\.md)|proposals/.*)$" && exit 0
    block "Promote writes only MEMORY.md, dream-log.md, proposals/." ;;
  *) exit 0 ;;
esac

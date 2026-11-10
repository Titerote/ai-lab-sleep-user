#!/usr/bin/env bash
# PreToolUse guard for dream sessions: each phase may write only its layer.
# Active only when DREAM_PHASE is set; otherwise a no-op. Exit 2 blocks the
# tool and feeds the message back to the model.
#
# Memory roots: agent-memory/<agent>/ (subagent auto memory) and
# agent-memory/_main/<project>/ (the main session's auto memory, relocated
# with autoMemoryDirectory). Both have the same layers:
#   L1  everything except MEMORY.md and wiki/   (notes/, topic files)
#   L2  wiki/ and issues.md
#   L3  MEMORY.md
set -u
[ -n "${DREAM_PHASE:-}" ] || exit 0
input="$(cat)"
path="$(python3 -c 'import json,sys; d=json.loads(sys.argv[1]); print(d.get("tool_input",{}).get("file_path") or d.get("tool_input",{}).get("path") or "")' "$input" 2>/dev/null)"
[ -n "$path" ] || exit 0
root="${CLAUDE_PROJECT_DIR:-$PWD}"
rel="${path#$root/}"

mem='agent-memory/(_main/[^/]+|[^/]+)'
block() { echo "Blocked: phase '$DREAM_PHASE' may not write '$rel'. $1 Raise it in issues.md instead." >&2; exit 2; }

case "$DREAM_PHASE" in
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

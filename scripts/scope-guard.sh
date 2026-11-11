#!/usr/bin/env bash
# PreToolUse guard for dream sessions: each phase may write only its layer.
# The phase comes from DREAM_PHASE (CLI: `DREAM_PHASE=settle claude --agent
# dreamer-settle`) or, when that is unset, from a `.dream-phase` file in the
# repo root (app/phone: the main session writes the file, then runs the phase
# as a subagent). No phase → no-op. Exit 2 blocks the tool and feeds the
# message back to the model.
#
# Memory roots: agent-memory/<agent>/ (subagent auto memory) and
# agent-memory/_main/<project>/ (the main session's auto memory, relocated
# with autoMemoryDirectory). Both have the same layers:
#   L1  everything except MEMORY.md and wiki/   (notes/, topic files)
#   L2  wiki/ and issues.md
#   L3  MEMORY.md
set -u
root="${CLAUDE_PROJECT_DIR:-$PWD}"
phase="${DREAM_PHASE:-}"
[ -n "$phase" ] || phase="$(tr -d '[:space:]' <"$root/.dream-phase" 2>/dev/null)"
[ -n "$phase" ] || exit 0
input="$(cat)"
path="$(python3 -c 'import json,sys; d=json.loads(sys.argv[1]); print(d.get("tool_input",{}).get("file_path") or d.get("tool_input",{}).get("path") or "")' "$input" 2>/dev/null)"
[ -n "$path" ] || exit 0
rel="${path#$root/}"

# The phase file itself is always writable (the main session sets and clears it).
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

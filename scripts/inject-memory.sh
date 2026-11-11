#!/usr/bin/env bash
# SessionStart hook: where auto memory is off (cloud VMs), print the memory
# indexes that auto memory would have loaded, so they enter the session's
# context the same way. Prints nothing on the Mac, where auto memory is on.
#
# Loads: the project's default-agent index (_main/<project>/MEMORY.md) and
# the user-level index (_user/MEMORY.md). Agents' own indexes are not loaded
# here: a subagent never sees the main session's context, so each memory:
# agent carries a pointer to read its own index instead. First 200 lines of
# each, matching auto memory's own limit.
set -u
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
M="$SLEEP_HOME/user/agent-memory"
cwd="${CLAUDE_PROJECT_DIR:-$PWD}"
slug="$(git -C "$cwd" remote get-url origin 2>/dev/null | sed -E 's#.*[/:]##; s#\.git$##')"
[ -n "$slug" ] || slug="$(basename "$cwd")"

emit() { # <label> <file>
  [ -s "$2" ] || return 0
  printf '\n## Memory: %s\nAuto memory is off in this environment; this is the index it would have loaded. Details live beside it under %s — read them when relevant. Do not write memory here; corrections you receive are captured from the transcript later.\n\n' "$1" "$(dirname "$2")"
  head -n 200 "$2"
}
emit "project default-agent ($slug)" "$M/_main/$slug/MEMORY.md"
emit "user" "$M/_user/MEMORY.md"
exit 0

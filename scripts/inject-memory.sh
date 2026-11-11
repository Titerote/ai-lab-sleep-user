#!/usr/bin/env bash
# SessionStart hook: load memory indexes that auto memory does not.
#
# - _user/MEMORY.md (facts about the person): auto memory has no user-level
#   memory, so this is printed everywhere.
# - _main/<project>/MEMORY.md (the project's default-agent index): printed
#   only where auto memory is off (cloud VMs); on the Mac auto memory loads it.
#
# Agents' own indexes are not loaded here: a subagent never sees the main
# session's context, so each memory: agent carries a pointer to read its own
# index, and promote mirrors the user rules that matter into those indexes.
# First 200 lines of each, matching auto memory's own limit. SessionStart
# stdout is added to the session's context.
set -u
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
M="$SLEEP_HOME/user/agent-memory"
cwd="${CLAUDE_PROJECT_DIR:-$PWD}"
slug="$(git -C "$cwd" remote get-url origin 2>/dev/null | sed -E 's#.*[/:]##; s#\.git$##')"
[ -n "$slug" ] || slug="$(basename "$cwd")"

emit() { # <label> <file>
  [ -s "$2" ] || return 0
  printf '\n## Memory: %s\nIndex loaded by the environment. Details live beside it under %s — read them when relevant.\n\n' "$1" "$(dirname "$2")"
  head -n 200 "$2"
}
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ]; then
  printf '\nAuto memory is off in this environment. Do not write memory here; corrections you receive are captured from the transcript and filed later.\n'
  emit "project default-agent ($slug)" "$M/_main/$slug/MEMORY.md"
fi
emit "user" "$M/_user/MEMORY.md"
exit 0

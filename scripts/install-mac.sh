#!/usr/bin/env bash
# One-time Mac install: symlinks so user-level agents and their memory come
# from this repo. Re-runnable. (Transcripts need no clone: ship.sh keeps one
# per project under $SLEEP_HOME/tx/, on that project's sleep/transcripts branch.)
set -euo pipefail
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
here="$(cd "$(dirname "$0")/.." && pwd)"
[ "$here" = "$SLEEP_HOME/user" ] || echo "note: this clone is at $here, expected $SLEEP_HOME/user (fine if intentional; set SLEEP_HOME to match)"
mkdir -p "$SLEEP_HOME" "$HOME/.claude"
link() { # link <target> <linkpath>
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak.$(date +%s)"; echo "backed up $2"; fi
  ln -sfn "$1" "$2"; echo "$2 -> $1"
}
link "$here/agents" "$HOME/.claude/agents"
link "$here/agent-memory" "$HOME/.claude/agent-memory"
chmod +x "$here"/scripts/*.sh
echo "done. Restart Claude Code so it picks up the agents directory."

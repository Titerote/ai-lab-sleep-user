#!/bin/bash
# Paste as the cloud environment's setup script. Runs as root before Claude
# Code launches; the result is snapshotted, so the clone here is a starting
# point and the project's SessionStart hook pulls it fresh each session.
set -x
SLEEP_HOME=/root/.ai-lab-sleep
mkdir -p "$SLEEP_HOME" /root/.claude
[ -d "$SLEEP_HOME/user/.git" ] || git clone https://github.com/Titerote/ai-lab-sleep-user "$SLEEP_HOME/user"
ln -sfn "$SLEEP_HOME/user/agents" /root/.claude/agents
ln -sfn "$SLEEP_HOME/user/agent-memory" /root/.claude/agent-memory
chmod +x "$SLEEP_HOME"/user/scripts/*.sh
git config --global user.name ship
git config --global user.email ship@ai-lab
exit 0

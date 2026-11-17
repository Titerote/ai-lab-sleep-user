#!/usr/bin/env bash
# scripts/dream.sh [phases...]   default: settle relate promote
#
# Runs a whole dream unattended on the Mac: one fresh interactive
# `claude --agent dreamer-<phase>` session per phase, started headless on a
# pty from the user clone, left to run until it commits `dream(<phase>)`,
# then closed. Phases run in order; a phase that commits nothing within
# DREAM_MINUTES (default 30) ends the dream with a non-zero exit.
#
# Billing: interactive CLI sessions on the subscription. The script refuses
# to run with ANTHROPIC_API_KEY set, because that silently reroutes billing.
# Meant for launchd: install a plist that runs this on a schedule from the
# runtime clone; stdout/stderr → $SLEEP_HOME/dream.log.
set -u
SLEEP_HOME="${SLEEP_HOME:-$HOME/.ai-lab-sleep}"
U="$SLEEP_HOME/user"
MINUTES="${DREAM_MINUTES:-30}"
CLAUDE="${CLAUDE_BIN:-$(command -v claude)}"
LOG="$SLEEP_HOME/dream.log"
log() { printf '%s %s\n' "$(date -u +%FT%TZ)" "$*" | tee -a "$LOG"; }

[ -n "${ANTHROPIC_API_KEY:-}" ] && { log "refusing: ANTHROPIC_API_KEY is set (would bill the API, not the subscription)"; exit 3; }
[ -x "$CLAUDE" ] || { log "claude not found"; exit 2; }
[ -d "$U/.git" ] || { log "no user clone at $U"; exit 2; }

cd "$U" || exit 2
git pull -q --ff-only || log "pull failed; dreaming on the local clone"
rm -f .dream-phase
phases="${*:-settle relate promote}"
log "dream start: $phases (user $(git rev-parse --short HEAD))"

for phase in $phases; do
  before=$(git rev-parse HEAD)
  TLOG="/tmp/dream-$phase-$(date -u +%Y%m%dT%H%M%SZ).log"
  log "$phase: starting (log $TLOG)"
  DREAM_PHASE="$phase" nohup script -q "$TLOG" "$CLAUDE" --agent "dreamer-$phase" "Run the $phase phase." >/dev/null 2>&1 </dev/null &
  start=$(date +%s); ok=0
  while :; do
    sleep 20
    if git log --format=%s "$before"..HEAD 2>/dev/null | grep -q "^dream($phase)"; then ok=1; break; fi
    if ! pgrep -qf "claude --agent dreamer-$phase"; then log "$phase: session exited without a dream($phase) commit"; break; fi
    if [ $(( $(date +%s) - start )) -gt $(( MINUTES * 60 )) ]; then log "$phase: timeout after $MINUTES min"; break; fi
  done
  sleep 5
  pkill -f "claude --agent dreamer-$phase" 2>/dev/null
  for _ in 1 2 3 4 5 6; do pgrep -qf "claude --agent dreamer-$phase" || break; sleep 5; done
  rm -f .dream-phase
  if [ $ok = 1 ]; then
    log "$phase: $(git log --format='%h %s' "$before"..HEAD | grep "dream($phase)" | head -1)"
    # the phase commits locally and pushes itself; make sure it reached origin
    [ "$(git rev-list --count HEAD ^origin/main 2>/dev/null)" = 0 ] || git push -q origin HEAD:main || log "$phase: push failed (left committed)"
  else
    log "dream aborted at $phase"; exit 1
  fi
done
log "dream done: $(git rev-parse --short HEAD)"

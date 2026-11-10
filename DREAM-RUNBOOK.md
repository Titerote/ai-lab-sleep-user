# Dream runbook (hand-run, Mac)

A dream is three fresh sessions, each the whole session running as one
dreamer agent, with the write scope enforced by the PreToolUse guard in this
repo's `.claude/settings.json` (active only when `DREAM_PHASE` is set).

```bash
cd ~/.ai-lab-sleep/user
git pull --ff-only
git -C ~/.ai-lab-sleep/transcripts pull --ff-only

DREAM_PHASE=settle  claude --agent dreamer-settle  "Run the settle phase."
DREAM_PHASE=relate  claude --agent dreamer-relate  "Run the relate phase."
DREAM_PHASE=promote claude --agent dreamer-promote "Run the promote phase."
```

Each session is interactive, so it bills to the subscription, not the Agent
SDK credit. Answer "continue" if a session stops to ask; do not add
instructions beyond the phase prompt — the lab is testing whether the prompts
are enough.

After the three phases:

```bash
cat agent-memory/*/dream-log.md
cat agent-memory/*/issues.md
git log --oneline -n 10
ls proposals/*/rules 2>/dev/null
```

Then the value check (T5 in the project's `TESTS.md`): in a fresh session on
the project, ask `noter` the question you corrected. It should answer from the
settled note, citing it, without being told.

Once a hand-run shows value, the same three commands become one claude.ai
routine on an environment that has this repo and the transcripts repo
attached; nothing in the prompts changes.

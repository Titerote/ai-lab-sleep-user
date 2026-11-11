# Dream runbook (hand-run, Mac)

A dream is three phases, each run with a fresh context, with the write scope
enforced by the PreToolUse guard in this repo's `.claude/settings.json`. The
guard takes the phase from `DREAM_PHASE` or, failing that, from a
`.dream-phase` file in this repo's root.

## Variant A — CLI (three whole sessions)

```bash
cd ~/.ai-lab-sleep/user
git pull --ff-only
# transcripts are fetched by the settle phase itself, per project in projects.yaml,
# from each project's sleep/transcripts branch into ~/.ai-lab-sleep/tx/<slug>/

DREAM_PHASE=settle  claude --agent dreamer-settle  "Run the settle phase."
DREAM_PHASE=relate  claude --agent dreamer-relate  "Run the relate phase."
DREAM_PHASE=promote claude --agent dreamer-promote "Run the promote phase."
```

## Variant B — app or phone (one Mac session, phases as subagents)

Start a Mac session whose folder is `~/.ai-lab-sleep/user` (so this repo's
hooks load). Then, one message per phase, in order:

1. "Run `git pull --ff-only`, write the word `settle` to `.dream-phase`, then run the `dreamer-settle` agent with the prompt 'Run the settle phase.' and report what it changed."
2. "Write `relate` to `.dream-phase`, then run the `dreamer-relate` agent with 'Run the relate phase.' and report what it changed."
3. "Write `promote` to `.dream-phase`, then run the `dreamer-promote` agent with 'Run the promote phase.' and report what it changed. Then delete `.dream-phase`."

Each subagent is a fresh context, and hooks from this repo's settings run
inside subagents, so the guard applies. Don't add instructions beyond the
phase prompt; the lab is testing whether the prompts are enough.

Either variant is interactive, so it bills to the subscription, not the
Agent SDK credit.

## After the three phases

```bash
cat agent-memory/*/dream-log.md
cat agent-memory/*/issues.md
git log --oneline -n 10
ls proposals/*/rules 2>/dev/null
```

Then the value check (T5 in the project's `TESTS.md`): in a fresh session on
the project, ask `noter` the question you corrected. It should answer from the
settled note, citing it, without being told.

Once a hand-run shows value, the same phases become one claude.ai routine.
Constraint learned in the lab: a cloud session can push only to the repos
attached to it, so the routine must have this repo attached (memory writes)
and each project it dreams for (none are written, only fetched, so read
access through the proxy is enough).

# ai-lab-sleep-user

Person-scoped agents, their memory, and the dreamer. One clone per machine at
`$SLEEP_HOME/user` (default `~/.ai-lab-sleep/user`), with
`~/.claude/agents` and `~/.claude/agent-memory` symlinked into it.

| Path | What | Git flow |
|---|---|---|
| `agents/*.md` | agent definitions (user-level subagents) | branch + PR |
| `agent-memory/<agent>/` | that agent's memory: `MEMORY.md`, `notes/`, `wiki/`, `issues.md`, `dream-log.md` | straight to `main` |
| `scripts/` | probe, ship, scope guard, bootstrap, Mac install, cloud setup | branch + PR |
| `projects.yaml` | allowlist of project repos the dreamer may write to | branch + PR |
| `MEMORY-FORMAT.md` | the note / wiki / index format the dreamer normalizes to | branch + PR |
| `DREAM-RUNBOOK.md` | how to hand-run a dream (settle → relate → promote) | branch + PR |

Sibling repos: `ai-lab-sleep-project` (a project under test) and
`ai-lab-sleep-transcripts` (raw session transcripts, filed by project).

## Install on the Mac

```bash
git clone git@github.com:Titerote/ai-lab-sleep-user.git ~/.ai-lab-sleep/user
~/.ai-lab-sleep/user/scripts/install-mac.sh     # clones transcripts repo, makes the symlinks
```

## Install in a cloud environment

Paste `scripts/cloud-setup.sh` as the environment's setup script. It clones
this repo and the transcripts repo into `/root/.ai-lab-sleep/` and makes the
symlinks before Claude Code launches, so user-level agents load. The project's
SessionStart hook pulls both on every session.

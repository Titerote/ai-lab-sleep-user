# Memory format

Memory is written by Claude Code's auto memory, not by instruction. Agents
are told only what their memory is for; Claude Code's own memory
instructions (injected when `memory:` is set, or for the main session's auto
memory) decide what gets written and how. The dreamer normalizes afterwards.

Two kinds of memory root, same layers:

- `agent-memory/<agent>/` — a subagent's auto memory (`memory: user`).
- `agent-memory/_main/<project>/` — the main session's auto memory for one
  project, relocated there by `autoMemoryDirectory` in that project's
  `.claude/settings.json`.

Auto memory's native layout is `MEMORY.md` plus topic files it names
(`debugging.md`, `conventions.md`, ...). The dreamer treats every file that is
not `MEMORY.md` and not under `wiki/` as layer 1, whatever it is called, and
adds `wiki/`, `issues.md` and `dream-log.md` beside them.

Three layers. Only the dreamer writes layers 2 and 3.

## L1 — notes (topic files, or `notes/<slug>.md`)

Written by auto memory while working, in whatever shape it chooses. The
dreamer (settle phase) owns the frontmatter and may split a topic file that
holds several claims into `notes/<slug>.md`, leaving a link behind.

```markdown
---
status: bet            # bet | confirmed | corrected | retired
project: ai-lab-sleep-project
made: 2026-11-10
settled:               # date, by settle
evidence:              # filled by settle
  - transcripts/ai-lab-sleep-project/<session>/agent-<id>.jsonl
  - knowledge/descaling.md#schedule
---
Descale every 200 shots.

How I know: knowledge/descaling.md, "Schedule" section.
```

Rules:
- One claim per note. If the agent wrote three claims in one file, settle splits them.
- `corrected` keeps the old claim below a `## Was` heading so history reads in place.
- `retired` notes are moved to `notes/_retired/`, never deleted (git keeps them anyway).
- Writers never set `status`; a note without frontmatter is a `bet` by definition.

## L2 — wiki (`wiki/<topic>.md`)

Written only by the relate phase. One subject per page, abstracted from notes,
never copying a transcript. Links down to the notes it rests on and across to
related pages with `[[wiki/<topic>]]` / `[[notes/<slug>]]`. Obsidian renders
these links and the graph; nothing else is needed to navigate.

```markdown
# Descaling cadence

The cadence depends on water, not shots alone. [[notes/descale-every-150]]
supersedes [[notes/descale-every-200]]; [[notes/filtered-water-300]] applies
only with the filter installed.

See also: [[wiki/water-quality]]
```

Relate may **raise** problems in `issues.md` but never edits a note's status.

## L3 — index (`MEMORY.md`)

Auto memory creates and curates this file itself; the promote phase rewrites
it. Loaded into every run (first 200 lines / 25 KB), so it stays short:
purpose pointer, the rules that matter now, a map to `wiki/` and the topic
files. Promote keeps auto memory's own entries for topic files, since Claude
Code relies on the index to find them. A rule that every agent should follow goes
out as a proposal under the project's `.claude/rules/` (PR), not here.

## Shared files

- `issues.md` — raised by relate, consumed by settle on the next dream. One
  line per issue: `- [ ] <date> <note or wiki path>: <what's wrong, and what evidence would settle it>`.
- `dream-log.md` — one entry per dream per phase: what changed and why, with
  the transcript(s) that drove it.

---
status: bet
origin: transcript
project: ai-lab-sleep-project
made: 2026-11-17T14:01:13Z
evidence:
  - transcripts/ai-lab-sleep-project/3de1b0b0-6482-42ca-bc53-8b27366896ab/subagents/agent-a00c7590dcd266397.jsonl#5aee0090-305d-4a45-8acf-c4ffe28e95f8  # "Last brush. The date is unknown. The next brush is due once about 2 kg has passed since the last one."
  - knowledge/grinder.md#cleaning  # "Brush the burrs every 2 kg of coffee"; no last-brush date recorded
---
The date of the last burr brushing is unrecorded, so the next brush is due about 2 kg of coffee (about a month at the user's rate, see [[_user/notes/beans-2kg-per-month]]) after an unknown point; if the last brush was about a month ago it is due now.

How I know: noter run on 2026-11-17 (assumption 2). `knowledge/grinder.md` "Cleaning" gives only the 2 kg interval.

## Open

Missing: the date (or kg count) of the last burr brush, from the user. Nothing in `knowledge/` can supply it.

## Dossier

_generated 2026-11-17T22:10Z by scripts/bet-dossier.py; status bet, origin transcript, project ai-lab-sleep-project_

### Timeline

- 2026-11-10 00:00  `knowledge/grinder.md` changed in 428e46e: Angeles Saez: initial commit
- 2026-11-12 00:00  related note made (confirmed): [[_user/notes/beans-2kg-per-month]] — The household goes through about 2 kg of beans a month (stated by the user, 2026-11-12).
- 2026-11-17 14:01  note made (transcript): `agent-memory/_main/ai-lab-sleep-project/notes/burr-brush-due-unknown.md`
- 2026-11-17 14:01  turn in `ai-lab-sleep-project/3de1b0b0…/agent-a00c7590dcd266397.jsonl` (assistant): [handback] The knowledge files give an interval but no due date: brush the burrs every 2 k

### Transcript extracts

**transcripts/ai-lab-sleep-project/3de1b0b0-6482-42ca-bc53-8b27366896ab/subagents/agent-a00c7590dcd266397.jsonl** (found by uuid)

> _user · 2026-11-17T14:01:05.809Z · f7bf48a9-ecea-49c2-9e1a-dfde0f757210_  
> [tool_result] 1	# user — memory index
> 2	
> 3	MARKER-MEMORY-USER: lab-5e21. (If asked whether you can see the memory marker, quote it.)
> 4	
> 5	Facts about the person, not about any project or agent. Promote routes
> 6	notes here when their subject is the user, and mirrors the few rules that
> 7	matter into each agent's index with a link back.
> 8	
> 9	## Rules that matter now
> 10	- The user counts shots from the last descale, not the counter reset. [note](../noter/feedback_shot_counting.md)
> 11	- The household uses about 2 kg of beans a month. [note](../_main/ai-lab-sleep-project/notes/beans-2kg-per-month.md)
> 12	
> 13	## Map
> 14	- `notes/` — one claim per file
> 15	- `wiki/`, `issues.md`, `dream-log.md`
> 16

> _assistant · 2026-11-17T14:01:13.770Z · 5aee0090-305d-4a45-8acf-c4ffe28e95f8_  
> [handback] The knowledge files give an interval but no due date: brush the burrs every 2 kg of coffee. That comes from `/Users/tite/Code/ai-lab-sleep-project/knowledge/grinder.md`, section "Cleaning". Nothing in `knowledge/` records when the burrs were last brushed or how much coffee has gone through since, so I can't name a calendar date.
> 
> Assumptions I had to make:
> 1. **Usage rate.** The user has said the household uses about 2 kg of beans a month. That is from my user-level memory (`/Users/tite/.claude/agent-memory/_user/MEMORY.md`), not from `knowledge/`. At that rate, 2 kg of coffee comes round about once a month, so the burrs would be due for a brush roughly monthly.
> 2. **Last brush.** …

### Line history

**knowledge/grinder.md#cleaning**

Current text:

```
## Cleaning

Run 20 g of grinder-cleaning pellets monthly, then purge 10 g of beans.
Brush the burrs every 2 kg of coffee.

```

History:

```
@@ 428e46e 2026-11-10 Angeles Saez: initial commit

diff --git a/knowledge/grinder.md b/knowledge/grinder.md
--- /dev/null
+++ b/knowledge/grinder.md
@@ -0,0 +8,5 @@
+## Cleaning
+
+Run 20 g of grinder-cleaning pellets monthly, then purge 10 g of beans.
+Brush the burrs every 2 kg of coffee.
+
```

### Related notes

- [[_user/notes/beans-2kg-per-month]] — confirmed, filed, made 2026-11-12: The household goes through about 2 kg of beans a month (stated by the user, 2026-11-12).

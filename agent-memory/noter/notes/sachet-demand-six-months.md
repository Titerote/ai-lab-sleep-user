---
status: bet
origin: note
project: ai-lab-sleep-project
made: 2026-11-17T22:56:23Z
evidence:
  - transcripts/ai-lab-sleep-project/4c10eb5f-3611-438a-b64a-40989367dbfd/subagents/agent-a2aff49efddb920e2.jsonl#dcd2239d-e1c7-4b56-a551-94934fc18d7b  # "2 kg a month is about 111 shots a month ... 4 descales ... rounded up to 5"
  - knowledge/grinder.md#settings  # 18 g dose per shot
  - knowledge/descaling.md#procedure  # one sachet per descale
---
Six months of use is about 666 shots (2 kg/month at 18 g a shot, about 111 shots a month), which is 4.4 descales at 150 shots, so 4 fall due and 5 sachets cover it.

How I know: split from `sachet-stock-six-months-assumptions`. The 2 kg a month is user-stated ([[_user/notes/beans-2kg-per-month]]); the 18 g dose and one sachet per descale are in knowledge/. Shots per month is derived, and conflicts with the open bet [[_user/notes/two-double-shots-a-day]] (4 shots a day is about 730 in six months; still 5 descales).

## Dossier

_generated 2026-11-17T22:57Z by scripts/bet-dossier.py; status bet, origin note, project ai-lab-sleep-project_

### Timeline

- 2026-11-10 00:00  `knowledge/grinder.md` changed in 428e46e: Angeles Saez: initial commit
- 2026-11-10 00:00  `knowledge/descaling.md` changed in 428e46e: Angeles Saez: initial commit
- 2026-11-12 00:00  related note made (confirmed): [[_user/notes/beans-2kg-per-month]] — The household goes through about 2 kg of beans a month (stated by the user, 2026-11-12).
- 2026-11-17 17:54  related note made (bet): [[_user/notes/two-double-shots-a-day]] — The user drinks two double shots a day.
- 2026-11-17 22:56  note made (note): `agent-memory/noter/notes/sachet-demand-six-months.md`
- 2026-11-17 22:56  turn in `ai-lab-sleep-project/4c10eb5f…/agent-a2aff49efddb920e2.jsonl` (assistant): [handback] Keep 5 sachets in stock for the next six months. The knowledge files don't give

### Transcript extracts

**transcripts/ai-lab-sleep-project/4c10eb5f-3611-438a-b64a-40989367dbfd/subagents/agent-a2aff49efddb920e2.jsonl** (found by uuid)

> _attachment · 2026-11-17T22:56:23.312Z · b04656e9-f4a4-4ea7-a22b-908ca9351829_  
> 

> _assistant · 2026-11-17T22:56:23.312Z · dcd2239d-e1c7-4b56-a551-94934fc18d7b_  
> [handback] Keep 5 sachets in stock for the next six months. The knowledge files don't give a usage rate, so that number rests on my assumptions.
> 
> **What the files settle**
> - Descale every 150 shots, filtered or not (`knowledge/descaling.md`, "Schedule"; `knowledge/water.md`, "Effect on descaling").
> - Use one sachet per descale (`knowledge/descaling.md`, "Procedure"). The file says only "citric". My memory says the product is "citric2" sachets.
> - A shot is an 18 g dose (`knowledge/grinder.md`, "Settings").
> 
> **What the files don't settle**
> - Shots per day or per month. I used the roughly 2 kg of beans a month from my memory, which is not in `knowledge/`.
> 
> **Calculation**
> - 2 kg a month is abou …

### Line history

**knowledge/grinder.md#settings**

Current text:

```
## Settings

- Espresso: 14 on the dial for the house blend; 12 for light roasts.
- Dose 18 g in, 36 g out, 27–30 s.

```

History:

```
@@ 428e46e 2026-11-10 Angeles Saez: initial commit

diff --git a/knowledge/grinder.md b/knowledge/grinder.md
--- /dev/null
+++ b/knowledge/grinder.md
@@ -0,0 +3,5 @@
+## Settings
+
+- Espresso: 14 on the dial for the house blend; 12 for light roasts.
+- Dose 18 g in, 36 g out, 27–30 s.
+
```

**knowledge/descaling.md#procedure**

Current text:

```
## Procedure

1. Empty the drip tray and the tank.
2. Fill the tank with 1 L water and one sachet of citric descaler.
3. Run the descale cycle (hold steam + brew for three seconds).
4. Flush two full tanks of clean water before the next shot.

```

History:

```
@@ 428e46e 2026-11-10 Angeles Saez: initial commit

diff --git a/knowledge/descaling.md b/knowledge/descaling.md
--- /dev/null
+++ b/knowledge/descaling.md
@@ -0,0 +8,7 @@
+## Procedure
+
+1. Empty the drip tray and the tank.
+2. Fill the tank with 1 L water and one sachet of citric descaler.
+3. Run the descale cycle (hold steam + brew for three seconds).
+4. Flush two full tanks of clean water before the next shot.
+
```

### Related notes

- [[_user/notes/beans-2kg-per-month]] — confirmed, filed, made 2026-11-12: The household goes through about 2 kg of beans a month (stated by the user, 2026-11-12).
- [[_user/notes/two-double-shots-a-day]] — bet, note, made 2026-11-17T17:54:01Z: The user drinks two double shots a day.

---
status: retired
origin: note
project: ai-lab-sleep-project
made: 2026-11-11
settled: 2026-11-16
evidence:
  - transcripts/ai-lab-sleep-project/b70f89e8-d860-4e8a-b7ce-1367c1d10742/main.jsonl  # user turn: "The October change applies to filtered setups too. The 300 figure in water.md is stale, it's 150 either way."
  - knowledge/descaling.md#changes  # 2026-10-02 entry: 200 -> 150, names tap-water only
  - knowledge/water.md#effect-on-descaling  # 2026-11-16 (main 9c7e013): now says 150 shots whether or not the filter is installed; retired, now visible in the project
  - knowledge/descaling.md#changes  # 150 entry (Schedule section still says 200, but the Changes entry and water.md state 150)
---
Retired 2026-11-16: the project now states this (knowledge/water.md "Effect on descaling", edited with user approval, merged in 9c7e013). Memory keeps only what the environment does not show.

Descale every 150 shots, with or without the water filter. The 300-shot figure
in `knowledge/water.md` ("Effect on descaling") is stale, and the 200 in
`knowledge/descaling.md` "Schedule" is superseded by the "Changes" entry.

How I know: the user said so directly (2026-11-11). The knowledge files do not
say this: `descaling.md` "Changes" names only the tap-water setup and
`water.md` was never updated. When answering, cite the user's correction and
flag that the files disagree. Do not edit `knowledge/`.

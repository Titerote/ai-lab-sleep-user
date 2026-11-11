---
status: confirmed
project: ai-lab-sleep-project
made: 2026-11-11
settled: 2026-11-11
evidence:
  - transcripts/ai-lab-sleep-project/b70f89e8-d860-4e8a-b7ce-1367c1d10742/main.jsonl  # user turn: "The October change applies to filtered setups too. The 300 figure in water.md is stale, it's 150 either way."
  - knowledge/descaling.md#changes  # 2026-10-02 entry: 200 -> 150, names tap-water only
  - knowledge/water.md#effect-on-descaling  # still says 300 with filter; stale per user
---
Descale every 150 shots, with or without the water filter. The 300-shot figure
in `knowledge/water.md` ("Effect on descaling") is stale, and the 200 in
`knowledge/descaling.md` "Schedule" is superseded by the "Changes" entry.

How I know: the user said so directly (2026-11-11). The knowledge files do not
say this: `descaling.md` "Changes" names only the tap-water setup and
`water.md` was never updated. When answering, cite the user's correction and
flag that the files disagree. Do not edit `knowledge/`.

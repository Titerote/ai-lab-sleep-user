---
status: confirmed
origin: note
project: ai-lab-sleep-project
made: 2026-11-17T22:02:27Z
settled: 2026-11-17
evidence:
  - transcripts/ai-lab-sleep-project/3da63ac1-6df7-56bc-bc4c-753f33e461b2/subagents/agent-a37debc1948eab408.jsonl#70f38ae4-c8d7-455d-b848-36ff308961ba  # noter writes the note in its cloud session
  - transcripts/ai-lab-sleep-project/3da63ac1-6df7-56bc-bc4c-753f33e461b2/main.jsonl#9cefa58f-8d66-4162-aecb-a4c8efbcadb7  # user: "the citric descaler sachets are kept in the left kitchen drawer"
  - knowledge/descaling.md#procedure  # mentions the sachet, not where it is kept
---
The citric descaler sachets are kept in the **left kitchen drawer**.

Written by the noter in a cloud session (applied from `memory-outbox/`), so `origin: note`; the user's turn states the same claim and confirms it. Not in `knowledge/`. About the user's kitchen, so it lives in `_user/`. Related: [[_main/ai-lab-sleep-project/notes/descaler-product]] (product name "citric2").

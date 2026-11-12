---
status: confirmed
origin: note
project: ai-lab-sleep-project
made: 2026-11-11
settled: 2026-11-11
evidence:
  - transcripts/ai-lab-sleep-project/edfe0f20-781c-469f-b262-23d97bc68f33/main.jsonl  # user turn: "I always count shots from the last descale, not from the counter reset"
  - transcripts/ai-lab-sleep-project/b70f89e8-d860-4e8a-b7ce-1367c1d10742/subagents/agent-aa669d0a8bd7d1170.jsonl  # checker: unsupported by knowledge, not contradicted
  - knowledge/descaling.md#schedule  # defines counting by machine counter (resets on 5s hold); user convention is a stated preference, user turn outranks
name: shot-counting-from-last-descale
description: User counts espresso shots since the last descale, not since the counter reset. Use that baseline when answering shot-count or descale-due questions.
metadata:
  type: feedback
---

The user counts shots from the last descale, not from the machine's counter reset.

**Why:** The user stated this directly as their standing convention ("for next time"). The two baselines can differ, so mixing them up would give a wrong answer about when a descale is due.

**How to apply:** When a question involves shot counts or the descale schedule (see `knowledge/descaling.md`), measure from the last descale. If the knowledge file phrases a threshold in terms of the counter reset, say so and note the difference rather than silently switching baselines.

---
name: shot-counting-from-last-descale
description: User counts espresso shots since the last descale, not since the counter reset. Use that baseline when answering shot-count or descale-due questions.
metadata:
  type: feedback
---

The user counts shots from the last descale, not from the machine's counter reset.

**Why:** The user stated this directly as their standing convention ("for next time"). The two baselines can differ, so mixing them up would give a wrong answer about when a descale is due.

**How to apply:** When a question involves shot counts or the descale schedule (see `knowledge/descaling.md`), measure from the last descale. If the knowledge file phrases a threshold in terms of the counter reset, say so and note the difference rather than silently switching baselines.

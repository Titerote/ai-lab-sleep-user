# knowledge/descaling.md, "Schedule": shot-counting baseline

File and section: `knowledge/descaling.md`, "Schedule" (line 5).

Status: the 200 -> 150 part is done and committed on origin/main (0bf559c); only the counting clause remains.

Current text: "Descale the boiler every 150 shots. Count shots on the machine's counter; it resets when you hold the brew button for five seconds."

Proposed text: "Descale the boiler every 150 shots. Count shots from the last descale, not from the counter reset." (or keep the counter wording; user to decide.)

Why: the user counts from the last descale; the file defines counting by the counter, which resets on a 5 s hold.

Source and evidence: [counting note](../../../agent-memory/_user/notes/feedback_shot_counting.md) (user turn edfe0f20.../main.jsonl#71097852-5ea8-4efd-9e2f-f17c213f06e0); [retired cadence note](../../../agent-memory/_main/ai-lab-sleep-project/notes/_retired/descale-150-both-setups.md); issue 2026-11-16 in `agent-memory/_main/ai-lab-sleep-project/issues.md`.

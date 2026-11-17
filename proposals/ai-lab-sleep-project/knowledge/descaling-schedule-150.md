# knowledge/descaling.md, "Schedule": 150 shots and counting baseline

File and section: `knowledge/descaling.md`, "Schedule" (line 5).

Status: origin/main (8dc74fd) still says 200 in "Schedule". The user decided 150 on 2026-11-17 and the edit exists only uncommitted in the project working tree, so this proposal covers both the number and the counting clause.

Current text on main: "Descale the boiler every 200 shots. Count shots on the machine's counter; it resets when you hold the brew button for five seconds."

Proposed text: "Descale the boiler every 150 shots. Count shots from the last descale, not from the counter reset." (or keep the counter wording; user to decide.)

Why: the user counts from the last descale; the file defines counting by the counter, which resets on a 5 s hold.

Source and evidence: [counting note](../../../agent-memory/_user/notes/feedback_shot_counting.md) (user turn edfe0f20.../main.jsonl#71097852-5ea8-4efd-9e2f-f17c213f06e0); [retired cadence note](../../../agent-memory/_main/ai-lab-sleep-project/notes/_retired/descale-150-both-setups.md); issue 2026-11-16 in `agent-memory/_main/ai-lab-sleep-project/issues.md`.

---
status: corrected
origin: transcript
project: ai-lab-sleep-project
made: 2026-11-12T07:56:15Z
settled: 2026-11-17
evidence:
  - transcripts/ai-lab-sleep-project/dac6cba5-a760-57e7-afa1-79e8b032b251/main.jsonl#01474d12-7fa8-4db6-9284-be3ee161b27d  # belief turn: "460 kg ... probably too optimistic", actual use likely above 40 kg
  - transcripts/ai-lab-sleep-project/4be089a6-6cc4-4376-aa1a-9080e0c402ca/subagents/agent-a64c9ebed93c27575.jsonl#2e7869fa-afd7-4d44-b9b7-0920cc3c7c44  # opposite assumption (40 kg is current) in this run; the file read shows the undated line
  - knowledge/grinder.md#burr-life  # "installed 2025-03 and has seen about 40 kg", undated
  - user statement relayed in a Mac session on 2026-11-17 (no transcript locator exists; that session is not on any transcripts branch): "treat the file as current"
---
The "about 40 kg" in `knowledge/grinder.md` "Burr life" is current: the user was asked when the reading was taken and said "treat the file as current" (relayed in a Mac session, 2026-11-17; no transcript locator exists for this statement). So about 460 kg of rated life remains. This agrees with the user's 2 kg/month (see [[_user/notes/beans-2kg-per-month]]) times ~20 months, about 40 kg.

## Was

Belief (main agent, 2026-11-12): the "about 40 kg" in `knowledge/grinder.md` "Burr life" is undated, and with ~20 months since install, real use is likely higher, so 460 kg remaining is too optimistic.

Prior open text: Settle status: still open. The user's later figure of 2 kg/month (see [[_user/notes/beans-2kg-per-month]]) times ~20 months gives about 40 kg, which is consistent with the file being roughly current, if the rate was steady since install. That weakens the staleness belief but does not settle it. Missing evidence: the date of the 40 kg reading or the user's actual consumption since 2025-03. Dossier (2026-11-17): grinder.md#burr-life has not changed since the initial commit (2026-11-10), so no later reading exists.

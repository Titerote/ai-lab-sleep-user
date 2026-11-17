
## 2026-11-12 settle
- Received notes/feedback_shot_counting.md from noter (status confirmed, origin note, unchanged).

## 2026-11-16 settle (second pass)
- No new transcripts since last_settled (all 15 session dirs already consumed); no outbox. Project main unchanged (9c7e013).
- Sweep (visible? / contradicted? / bet? / right root? / action):
  - _main/ai-lab-sleep-project/notes/beans-2kg-per-month.md (confirmed, filed): no / no / closed (user-stated record) / yes / none. Rate not in knowledge (grinder.md only says brush every 2 kg).
  - _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale.md (bet, transcript): no / no / open; missing the date of the 40 kg reading or actual use since 2025-03 (grinder.md:16 still undated) / yes / none.
  - _main/ai-lab-sleep-project/notes/descaler-product.md (confirmed, note): no (citric2 not in project) / no / closed / yes / none.
  - _user/notes/feedback_shot_counting.md (confirmed, note): no / no / closed / yes (user convention) / none.
- issues.md: the open descaling.md Schedule 200 vs 150 issue stays open; no new evidence.
- Counts settled this run by origin: note 0 / transcript 0 / filed 0.

## 2026-11-16 settle (third pass)
- No new transcripts (15 session dirs, all consumed), no outbox; project main still 9c7e013. Repo only gained c0f84be (agents/dreamer-relate.md), not a memory change.
- Sweep, unchanged from the second pass: beans-2kg-per-month (confirmed/filed, keep), burr-40kg-figure-may-be-stale (bet/transcript, open; missing date of the 40 kg reading or use since 2025-03), descaler-product (confirmed/note, keep), feedback_shot_counting (confirmed/note, right root). Visible? no for all; contradicted? no for all; right root yes for all; no action.
- Open issue (descaling.md Schedule 200 vs 150) still awaits the user.
- Counts settled by origin: note 0 / transcript 0 / filed 0. dream-state.json not changed (last_settled already 2026-11-16, same project main).

## 2026-11-17 settle (updated instructions: locators, dossier, routing test)
- No new transcripts (15 session dirs, all consumed), no outbox; project main 9c7e013.
- Applied to all existing notes: evidence rewritten as locators with record uuids (beans f908d6e6, descaler 75a92983, shot counting 71097852, burr dac6cba5#01474d12 and subagent #2e7869fa); grinder.md cited by line/section. Dropped the checker evidence line from feedback_shot_counting (no resolvable record).
- Routing: beans-2kg-per-month moved _main -> _user/notes (a household rate answers the same question in any project); stub left at old path.
- Dossier run for the one open bet (burr-40kg-figure-may-be-stale): grinder.md#burr-life unchanged since initial commit 428e46e (2026-11-10), so no later reading; stays open, `## Open` written, line added to issues.md.
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / closed / yes (moved from _main) / moved, locator fixed
  - _main/.../notes/burr-40kg-figure-may-be-stale (bet, transcript): no / no / open / project / dossier + Open + issue
  - _main/.../notes/descaler-product (confirmed, note): no / no / closed / project (descaler product of this machine) / locator fixed
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / closed / yes / locator fixed
  - _main/.../notes/beans-2kg-per-month (stub): n/a
- Counts settled by origin: note 0 / transcript 0 / filed 0 (no new settlements; filed note moved).
- Limitation: bet-dossier resolves related notes only within the same root, so the cross-root link [[_user/notes/beans-2kg-per-month]] shows no dossier entry.

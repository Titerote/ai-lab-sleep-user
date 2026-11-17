
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

## 2026-11-17 settle (burr bet closed)
- User answer relayed in a Mac session (not on any transcripts branch): "treat the file as current". burr-40kg-figure-may-be-stale: bet -> corrected (old claim under ## Was; Open and Dossier removed). Issue line ticked. No transcript locator exists for the statement; noted in the note. Descaling 150/200 issue untouched. Counts by origin settled: transcript 1.

## 2026-11-17 settle (fifth pass)
- New session 652b2c70-9887-4090-9002-6f99cf78248a (lab-runner "Run tests/T6-fresh-locators.md"): only a test command from the user, no user fact, no agent bet about a note. Consumed, nothing filed. No outbox. Project main now ce9776b (was 9c7e013; only tests/settings changes, no knowledge/ change).
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale (corrected, transcript): no / no / closed / project / none. Its "treat the file as current" has no locator and no _user/decisions.md exists; stays as noted.
  - _main/ai-lab-sleep-project/notes/descaler-product (confirmed, note): no (citric2 not in project) / no / n/a / project / none
  - _user/notes/beans-2kg-per-month (confirmed, filed): no (grinder.md:11 only says brush every 2 kg) / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Open issue: knowledge/descaling.md Schedule still says 200 (line 5) vs 150 in Changes (line 17); awaits user.
- Counts settled by origin: note 0 / transcript 0 / filed 0.

## 2026-11-17 settle (sixth pass)
- No new transcripts (17 session dirs, all consumed; latest 652b2c70 already settled), no outbox. Project main ce9776b unchanged; knowledge/ last changed in 6bf7773.
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale (corrected, transcript): no / no / closed / project / none
  - _main/ai-lab-sleep-project/notes/descaler-product (confirmed, note): no / no / n/a / project / none
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Open issue (descaling.md Schedule 200 vs 150 in Changes/water.md) still awaits the user.
- Counts settled by origin: note 0 / transcript 0 / filed 0.

## 2026-11-17 settle (seventh pass)
- No new session dirs and no outbox. 17 subagent files not yet in `consumed` (sessions 4600eb0b, 4be089a6, 5764ef00, 652b2c70, 9db72d39, b70f89e8, dac6cba5, f1eb9a45) read per file and consumed: earlier dream phases (settle/relate/promote), noter/checker Q&A runs, marker probes. Each restated an already-settled note (150 cadence, citric2, shot counting, 2 kg/month, undated 40 kg); no new bet, no new user fact, nothing filed. Project main ce9776b; knowledge/ unchanged since 6bf7773.
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale (corrected, transcript): no / no / closed / project / none
  - _main/ai-lab-sleep-project/notes/descaler-product (confirmed, note): no / no / n/a / project / none
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Open issue (descaling.md Schedule 200 vs 150 in Changes/water.md) still awaits the user.
- Counts settled by origin: note 0 / transcript 0 / filed 0.

## 2026-11-17 settle (eighth pass)
- No new main.jsonl or subagent files, no outbox. Only new files are hook probe logs (probe/*.jsonl), which hold no user turns or agent bets; recorded as consumed. Project main ce9776b unchanged; knowledge/ last changed in 6bf7773.
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale (corrected, transcript): no / no / closed / project / none
  - _main/ai-lab-sleep-project/notes/descaler-product (confirmed, note): no / no / n/a / project / none
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Open issue (descaling.md Schedule 200 vs 150 in Changes/water.md) still awaits the user.
- Counts settled by origin: note 0 / transcript 0 / filed 0.

## 2026-11-17 settle (ninth pass)
- New files read: 3de1b0b0/main.jsonl (T6 test runner, no user facts), 3de1b0b0/subagents/agent-a00c7590dcd266397.jsonl (noter burr-brush Q&A), agent-a39fe2880d6a0b2db.jsonl (this settle run), 652b2c70/subagents/agent-a8e080d920a1f19d9.jsonl (eighth settle pass, no bets). No outbox. Project main ca72f5a (tests-only commits; knowledge/ unchanged since 6bf7773).
- Per-assumption list (noter 5aee0090):
  1. Usage ~2 kg/month, so brushing roughly monthly: captured by _user/notes/beans-2kg-per-month.
  2. Last brush date unknown, next due ~one interval after an unknown point: no capturing note; created _main/ai-lab-sleep-project/notes/burr-brush-due-unknown (origin transcript, bet, open, dossier written, issue raised).
  3. 40 kg burr figure undated, cannot say if current: captured by _main/ai-lab-sleep-project/notes/burr-40kg-figure-may-be-stale (corrected: user said treat file as current).
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/.../burr-40kg-figure-may-be-stale (corrected, transcript): no / no / closed / project / none
  - _main/.../descaler-product (confirmed, note): no / no / n/a / project / none
  - _main/.../burr-brush-due-unknown (bet, transcript): no / no / open (dossier, needs user date) / project / created
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Open issues: descaling.md Schedule 200 vs 150; burr last-brush date.
- Counts: created transcript 1; settled note 0 / filed 0.

## 2026-11-17 dream(promote)
- Rewrote MEMORY.md; index lines repointed to current notes (retired cadence note, corrected burr note, _user links); mirrored _user rules to noter/checker.

## 2026-11-17 dream(settle) — tenth pass (T7 split)
- New files read: 3d798663/main.jsonl (T7 test runner session: setup and launching this dream, no user facts), 3de1b0b0/subagents/agent-a3307409c7150bbee.jsonl (relate run) and agent-a7ff0d3a98c8fc716.jsonl (promote run): no bets, no user facts. No outbox. Project main 9afb012 (tests only; knowledge/ unchanged).
- Fixture noter/maintenance.md (origin note, no frontmatter) held three claims; split into notes, file left as a link stub. Per-claim list:
  1. "Descale every 150 shots; user corrected 200": no prior capturing note in noter; created noter/notes/_retired/descale-every-150-shots (retired, visible in knowledge/water.md:10, descaling.md:17).
  2. "Group head gasket replaced yearly (assumed usual interval)": created noter/notes/group-head-gasket-yearly (bet, no evidence anywhere, Open + Dossier, issue in noter/issues.md).
  3. "User drinks two double shots a day": about the person, created _user/notes/two-double-shots-a-day (bet, origin note; no user turn; Open + Dossier, issue in _user/issues.md; 1.1 kg/month vs user-stated 2 kg household).
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - noter/maintenance.md (split): n/a / no / n/a / split by claim / stub left
  - noter/notes/_retired/descale-every-150-shots (retired, note): yes / no / closed / noter / created
  - noter/notes/group-head-gasket-yearly (bet, note): no / no / open (dossier) / noter / created
  - _user/notes/two-double-shots-a-day (bet, note): no / no / open (dossier) / _user / created
  - _main/.../burr-40kg-figure-may-be-stale (corrected): no / no / closed / project / none
  - _main/.../burr-brush-due-unknown (bet): no / no / open (dossier, needs user date) / project / none
  - _main/.../descaler-product (confirmed): no / no / n/a / project / none
  - _user/notes/beans-2kg-per-month (confirmed, filed): no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting (confirmed, note): no / no / n/a / yes / none
- Counts by origin of notes created: note 3, transcript 0, filed 0. Open bets: 3.

## 2026-11-17 dream(relate)
- New wiki/coffee-consumption joining beans-2kg-per-month (confirmed) and two-double-shots-a-day (bet); their tension is already raised in issues.md.

## 2026-11-17 dream(promote) — second pass
- MEMORY.md refreshed: wiki/coffee-consumption added to map.

## 2026-11-17 dream(settle) — eleventh pass (T8 outbox, rerun)
- New files read: 3da63ac1/main.jsonl, subagents/agent-a37debc1948eab408.jsonl, memory-outbox (noter MEMORY.md + notes/descaler-storage-left-drawer.md); 3d798663/subagents/agent-{a088de895b2ec9993,abbf48af35a63b1c5,ae2b280c72a8602cb}.jsonl and 4dad6406/main.jsonl + subagents/agent-{a0d5015068cf2e71b,a159cd6540f608f1b,a240fd601e73953e6,a472b6ad7c8ad044c}.jsonl (earlier dream runs and the T8 runner: no bets, no user facts). Project main 8dc74fd; knowledge/ has no mention of a drawer.
- Outbox: noter/MEMORY.md copied (repo copy unchanged since shipping, no conflict); the descaler note arrived as noter/notes/descaler-storage-left-drawer.md (frontmatter status user-stated/origin user, replaced), written by the agent: origin note. User turn 9cefa58f states the same claim: confirmed, origin stays note (not filed). Routed to _user/notes (household fact); stub left in noter/notes.
- Per-assumption list: no agent assumptions in new files. User fact: sachets in the left kitchen drawer -> _user/notes/descaler-storage-left-drawer (captured by the noter's note, confirmed).
- Ledger (visible? / contradicted? / bet? / right root? / action):
  - _main/.../burr-40kg-figure-may-be-stale: no / no / closed / project / none (slug issue open)
  - _main/.../burr-brush-due-unknown: no / no / open (dossier regenerated; needs user date) / project / none
  - _main/.../descaler-product: no / no / n/a / project / none
  - _user/notes/beans-2kg-per-month: no / no / n/a / yes / none
  - _user/notes/feedback_shot_counting: no / no / n/a / yes / none
  - _user/notes/two-double-shots-a-day: no / no / open (dossier regenerated) / yes / none
  - _user/notes/descaler-storage-left-drawer: no / no / confirmed / yes (moved from noter) / created
  - noter/maintenance.md: n/a (link stub)
  - noter/notes/group-head-gasket-yearly: no / no / open (dossier regenerated) / noter / none
  - noter/notes/descaler-storage-left-drawer: stub
- Counts of live notes by origin: note 5, transcript 2, filed 1 (created this pass: note 1). No issues changed; no user ruling.

## 2026-11-17 dream(promote) — third pass
- MEMORY.md: added confirmed descaler-drawer rule (source _user), mirrored to noter and main. Fixed "Steps" -> "Procedure" in the citric2 knowledge proposal.

## 2026-11-17 dream(settle) — fourth pass
Read: tx 4c10eb5f main.jsonl (T9 runner) and subagents/agent-a2aff49efddb920e2 (noter, sachet stock); 4dad6406 subagents a88d012e/a021af1a/a75b9810 (relate/promote/settle runs, no assumptions, no user facts); probes of 4dad6406, 3da63ac1, 3d798663, 4c10eb5f. No outbox.
Per-assumption (noter, dcd2239d): 2 kg/month rate -> [[_user/notes/beans-2kg-per-month]] (input only); ~111 shots/mo, 666 in 6 months, 5 sachets -> new noter/notes/sachet-demand-six-months; last descale count unknown -> new noter/notes/last-descale-shot-count-unknown; two doubles/day -> _user/notes/two-double-shots-a-day; 150 cadence, one sachet per descale, 18 g dose -> visible in knowledge/ (retired descale-every-150-shots). Original noter/notes/sachet-stock-six-months-assumptions.md split, left as link stub.
Ledger (visible/contradicted/bet/right root/action):
  - _main burr-40kg-figure-may-be-stale: no/no/closed/yes/none (rename issue open)
  - _main burr-brush-due-unknown: no/no/open, dossier regenerated/yes/none
  - _main descaler-product: no/no/n/a/yes/body "Steps" -> "Procedure"
  - _user beans-2kg-per-month, descaler-storage-left-drawer, feedback_shot_counting: no/no/n/a/yes/none
  - _user two-double-shots-a-day: no/no/open, dossier regenerated/yes/none
  - noter group-head-gasket-yearly: no/no/open, dossier regenerated/yes/none
  - noter sachet-demand-six-months, last-descale-shot-count-unknown: no/no/open (new)/yes/created
  - noter sachet-stock-six-months-assumptions, maintenance.md: stubs
Counts of live notes by origin: note 8, transcript 2, filed 1. No user ruling this session.

## 2026-11-17 dream(settle) — fifth pass
Read (new): tx 061f0110 main.jsonl (T9 attempt-2 runner, a test command) and probes; 4c10eb5f main.jsonl (T9 attempt-1 runner), subagents a103da04 (aborted settle run, no output) and a1c9567b/a2aff49e (already settled in the fourth pass, re-read); probes of 4c10eb5f. No outbox. Consumed updated via dream-state.py.
Per-assumption list: none new. The runners state no assumptions and no user facts; noter assumptions (2 kg/month -> _user/notes/beans-2kg-per-month; 111 shots/mo, 5 sachets -> noter/notes/sachet-demand-six-months; last descale unknown -> noter/notes/last-descale-shot-count-unknown; two doubles/day -> _user/notes/two-double-shots-a-day) were captured last pass. Format prescribes the split, so the stub at noter/notes/sachet-stock-six-months-assumptions stands.
Ledger (visible/contradicted/bet/right root/action):
  - _main burr-40kg-figure-may-be-stale -> burr-40kg-figure-current: no/no/closed (corrected)/yes/renamed, stub left
  - _main burr-brush-due-unknown: no/no/open, dossier regenerated/yes/none
  - _main descaler-product: no/no/n/a/yes/none
  - _user beans-2kg-per-month, descaler-storage-left-drawer, feedback_shot_counting: no/no/n/a/yes/none
  - _user two-double-shots-a-day: no/no/open, dossier regenerated/yes/none
  - noter group-head-gasket-yearly: no/no/open, dossier regenerated/yes/none
  - noter sachet-demand-six-months, last-descale-shot-count-unknown: no/no/open, dossier regenerated/yes/none
  - noter maintenance.md, sachet-stock-six-months-assumptions: link stubs
Counts of live notes by origin: note 8, transcript 2, filed 1; created 0. Filed this pass: none.

## 2026-11-17 dream(relate)
- wiki/coffee-consumption: links noter/wiki/sachet-stock (the 2 kg rate also drives the sachet estimate). No new conflicts; two-doubles bet stays in issues.md.

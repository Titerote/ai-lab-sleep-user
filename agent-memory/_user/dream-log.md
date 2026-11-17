
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

## 2026-11-17 settle (pass 3, cloud outbox)

Read (new): 3d798663 subagents a088de89/abbf48af/ae2b280c (dream phases: settle/promote/relate runs, no bets), 3da63ac1 main + subagent a37debc1 + memory-outbox (noter, cloud), 4dad6406 main + subagent a0d50150 (this settle run, T8 test prompt). Project main 8dc74fd.

Outbox applied: `noter/MEMORY.md` (repo copy unchanged since last_shipped; no conflict), `noter/notes/descaler-storage-left-drawer.md`.

Assumptions per file: none stated by agents in new transcripts (3da63ac1 agent only recorded a user statement). User fact: sachets kept in left kitchen drawer (3da63ac1 main#9cefa58f) -> new `_user/notes/descaler-storage-left-drawer.md`, confirmed, origin filed (a record, not a settlement); stub left at noter/notes/.

Ledger (visible / contradicted / bet / root / action):
- _main/.../burr-40kg-figure-may-be-stale: no / no / no / ok / none
- _main/.../burr-brush-due-unknown: no / no / open bet, dossier regenerated, Open kept / ok / issue line added
- _main/.../descaler-product: no / no / no / ok / none
- _user/notes/beans-2kg-per-month: no / no / no / ok / none
- _user/notes/feedback_shot_counting: no / no / no / ok / none
- _user/notes/two-double-shots-a-day: no / no / open bet, dossier regenerated / ok / issue already open
- _user/notes/descaler-storage-left-drawer: no / no / no / ok (moved from noter) / created
- noter/notes/group-head-gasket-yearly: no (grep finds no gasket in project) / no / open bet, dossier regenerated / ok / issue already open
- noter/maintenance.md: link stub, no claim

Counts by origin (live notes): note 5 (incl. stub-less), transcript 2, filed 3.

## 2026-11-11 settle
- `descaler-product.md`: bet -> confirmed. User stated "citric2 sachets" (9bf920a0); knowledge only says "citric descaler", compatible.
- New `notes/descale-150-both-setups.md` (confirmed): user correction in b70f89e8 that 150 shots applies filtered too; water.md's 300 is stale. Knowledge files left unedited and still disagree.
- Transcripts: 9bf920a0-6432-424f-85a9-cb26faa95501, b70f89e8-d860-4e8a-b7ce-1367c1d10742.

## 2026-11-11 relate
- New `wiki/descaling.md` joining descale-150-both-setups, descaler-product and noter's feedback_shot_counting.
- `issues.md`: water.md 300 vs 150 conflict; dangling [[descaling-schedule]] in descaler-product.

## 2026-11-11 promote
- Rewrote MEMORY.md with rules from confirmed notes (150 cadence, citric2, shot baseline) and wiki map.
- Proposal: proposals/ai-lab-sleep-project/rules/descale-cadence-150.md.

## 2026-11-12 settle
- No memory-outbox in any new session; nothing to apply.
- New `notes/beans-2kg-per-month.md` (confirmed, origin filed): user said ~2 kg beans/month (4be089a6). A record, not a settled bet.
- New `notes/burr-40kg-figure-may-be-stale.md` (bet, origin transcript): main agent in dac6cba5 doubted the undated 40 kg burr figure; noter in 4be089a6 assumed it current. User's 2 kg/month x ~20 months ~ 40 kg leans against staleness but does not settle it; left open.
- `descaler-product.md`: dangling [[descaling-schedule]] -> [[wiki/descaling]]; issue ticked. Set `origin: note` on it, on `descale-150-both-setups` and on noter's `feedback_shot_counting`.
- 150-vs-300 issue remains open; 9db72d39 and 5764ef00 reuse the confirmed note, no new evidence.
- Sessions with no claims to settle: 3b4dc28f (tailscale/ollama commands), b7599df9, d1e73852, df733d06 (lab-marker probes).
- Counts settled by origin: note 0 re-settled (3 origin fields backfilled) / transcript 0 (1 left as bet) / filed 1.

## 2026-11-12 relate
- New `wiki/grinder-burr-life.md` joining beans-2kg-per-month and burr-40kg-figure-may-be-stale.
- `wiki/descaling.md` unchanged. Checker has no notes; noter's single note already covered.
- `issues.md`: bare-name links in wiki/descaling depend on file locations.

## 2026-11-12 promote
- MEMORY.md rewritten: added burr/beans notes and grinder wiki to map; descaler rule mirrored to noter.

- Promote 2026-11-12: new proposal proposals/ai-lab-sleep-project/rules/descaler-product-citric2.md; shot-counting and beans rules mirrored into agent-memory/_user/MEMORY.md.

## 2026-11-12 settle (second pass)
- New session since last pass: d1e73852 (probe-only, no main.jsonl); nothing to settle. No outbox.
- Moves: descaler-product -> _main/.../notes/; noter/feedback_shot_counting -> _user/notes/ (user convention). Stubs left. Wiki-link issue ticked.
- 150-vs-300 water.md issue already ticked; no new evidence.
- Counts settled by origin: note 0 / transcript 0 / filed 0.

## 2026-11-16 settle
- New sessions: 6b877565 (Thorne supplement question), 762cb005 (nutritionist interview prep; user noted it was the wrong project), 9f3f4c45 (probe only). None touch project notes; personal nutrition/triathlon facts not filed (off-project, user said wrong environment). No outbox.
- Retired notes/descale-150-both-setups (moved to notes/_retired/): knowledge/water.md now says 150 either way (project main 9c7e013).
- Sweep: descaler-product (citric2) still user-only, stays confirmed. burr-40kg-figure-may-be-stale stays bet; missing: date of the 40 kg reading or actual consumption since 2025-03 (grinder.md unchanged, still undated). beans note unchanged.
- Raised issue: descaling.md Schedule (200) vs Changes/water.md (150).
- Counts settled by origin: note 1 (retired) / transcript 0 / filed 0.

## 2026-11-16 settle (second pass)
- No new transcripts or outbox; no note changed. Sweep results as in _user/dream-log.md. Open issue (descaling.md Schedule 200 vs 150) still awaits the user.

## 2026-11-16 settle (third pass)
- No new transcripts or outbox; no note changed. Sweep as in _user/dream-log.md.

## 2026-11-17 settle (updated instructions)
- No new transcripts. Moved beans-2kg-per-month to _user/notes (stub left). Locators rewritten on descaler-product and burr note; burr dossier generated, bet stays open, issue line added. See _user/dream-log.md.

## 2026-11-17 settle (burr bet closed)
- burr-40kg-figure-may-be-stale corrected per user ("treat the file as current"); issue ticked.

## 2026-11-17 settle (ninth pass)
- Added open bet notes/burr-brush-due-unknown (origin transcript) from noter run 3de1b0b0/agent-a00c7590dcd266397; issue raised. Other notes unchanged. Details in _user/dream-log.md.

## 2026-11-17 dream(relate)
- Rewrote wiki/descaling: cadence link repointed to notes/_retired/descale-150-both-setups (retired, now in knowledge; Schedule 200 still open), shot-counting to [[_user/notes/feedback_shot_counting]], product to [[notes/descaler-product]]; bare-name links fixed.
- Rewrote wiki/grinder-burr-life: burr 40 kg note now corrected (file current), beans link repointed to _user/notes, added open bet notes/burr-brush-due-unknown.
- All wiki links resolve; no dangling links in notes; no note-vs-note contradictions. Raised: stale index lines (MEMORY.md _main and noter), burr-40kg slug contradicts its corrected claim.
- No wiki for _user, noter, checker roots: no subject there has two notes in that root alone (cross-root subjects covered by the project pages).

## 2026-11-17 dream(promote)
- Rewrote MEMORY.md; index lines repointed to current notes (retired cadence note, corrected burr note, _user links); mirrored _user rules to noter/checker.
- Proposals: rule-lane cadence and citric2 proposals withdrawn (facts, not rules); replaced by knowledge proposals descaling-schedule-150 and descaler-product-citric2.

## 2026-11-17 dream(relate) — after T7 split
- wiki/descaling: cadence now rests on both retired notes (_main descale-150-both-setups, noter descale-every-150-shots: same lesson, two agents); Schedule line updated (user ruled 150, edit in project working tree, not on main yet).
- wiki/grinder-burr-life: links new _user/wiki/coffee-consumption.
- issues.md: index-lag issue ticked (fixed by promote cf180e7). No new note-vs-note conflicts; two-doubles vs 2 kg already in _user/issues.md.
- noter/notes/group-head-gasket-yearly: single note on its subject, no page. All [[...]] in wiki/ and notes resolve.

## 2026-11-17 dream(promote) — second pass
- MEMORY.md refreshed: cadence rule reflects the Schedule edit in the working tree; linked _user coffee wiki; descaling-schedule-150 proposal narrowed to the counting clause.

## 2026-11-17 settle (pass 3)
No new transcripts bearing on this root. burr-brush-due-unknown stays an open bet; dossier regenerated, issue line added.

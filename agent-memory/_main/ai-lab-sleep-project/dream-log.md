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

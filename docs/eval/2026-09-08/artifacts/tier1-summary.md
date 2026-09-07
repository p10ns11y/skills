# SkillEvaluator Tier1 (2026-09-08 IST)

Targets: top skills `agent-orchestrator`, `ai-optimization` + plugin skill `mission-map`.
Tool: NVIDIA SkillEvaluator 0.2.1 (`quality-check`). Orca run `run_94be10c65fb7` with Grok worker ready; cursor worker stalled (`agent_prompt_stalled`). Coordinator also ran Tier1 locally so results are not blocked on Orca TUI.

## Scores

| Target | Kind | Grade | Score | Correctness | Discoverability | Reliability | Efficiency |
|--------|------|-------|-------|-------------|-----------------|-------------|------------|
| agent-orchestrator | skill | B | 87.0 | 85 | 90 | 85 | 90 |
| ai-optimization | skill | B | 80.0 | 65 | 90 | 85 | 90 |
| mission-map | plugin skill | B | 86.0 | 85 | 90 | 75 | 100 |

All three **PASS** quality gate (≥70).

## Common nits
- Missing recommended frontmatter: `version`, `metadata.author`, `metadata.tags`
- Long descriptions (>150 chars recommended)
- Missing Purpose / Limitations / Troubleshooting sections (LOW)

## ai-optimization specific
- Correctness 65: wants Available Scripts table + `run_script` examples (hybrid skill type)

## Tier2/3 Skill Lift
**NEEDS_KEY** — no `NVIDIA_API_KEY` / provider in this shell for live with/without-skill runs. Kick again with key for `validate --full` / `tier3 evaluate`.

## Orca orchestration notes
- Runtime: `orca serve --no-pairing` (flaky between long gaps)
- Grok worker: `term_09cb4d76…` dispatch ready on worktree `skill-eval-grok`
- Cursor worker: failed stage `dispatch_input` / `agent_prompt_stalled` — retry with focused TUI or `terminal send` when Orca desktop is open

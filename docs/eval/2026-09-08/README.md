# SkillEvaluator pass — 2026-09-08

NVIDIA [SkillEvaluator](https://docs.nvidia.com/skills/skillevaluator) Tier1 quality scores for two top skills in this repo, plus notes on a blocked Tier2/Tier3 Skill Lift attempt. Plugin `mission-map` was evaluated in the same wave; its write-up lives in `p10ns11y/plugins` (`docs/eval/2026-09-08/`).

## Results (Tier1 `quality-check`)

| Skill | Grade | Score /100 | Correctness | Discoverability | Reliability | Efficiency | Type |
|-------|-------|------------|-------------|-----------------|-------------|------------|------|
| [agent-orchestrator](../../agent-orchestrator/) | **B** | **87.0** | 85 | 90 | 85 | 90 | resource-based |
| [ai-optimization](../../ai-optimization/) | **B** | **80.0** | 65 | 90 | 85 | 90 | hybrid |

Gate: quality-check **PASS** (≥70) for both.

### Tier2 / Tier3 (Skill Lift)

| Tier | Status | Why |
|------|--------|-----|
| Tier2 dedup | **FAIL** | Provider 401 — `OPENAI_API_KEY` in the shell was not a valid OpenAI key (wrong provider material). |
| Tier3 live Skill Lift | **SKIPPED** | Docker missing on mzapan; staging tree incomplete; no completed with/without-skill arms. |

Raw CLI transcripts (redacted): [artifacts/](artifacts/).

## How we ran it (tools → tasks)

Pipeline used on laptop **mzapan** under CoS token lock (no Cursor cloud agents):

```text
tools
  ├── Orca ADE (`orca serve` + orchestration Run)
  ├── Grok Build (Orca worker `--agent grok`)
  ├── cursor-agent (Orca worker `--agent cursor` — stalled on prompt)
  ├── NVIDIA SkillEvaluator 0.2.1 (`uv tool install …SkillEvaluator`)
  └── local shell (coordinator fallback when Orca TUI flaked)

tasks
  1. Pick top-2 skills (README install set) + one plugin skill
  2. Orca Run `run_94be10c65fb7` + tasks for Grok Tier1 / cursor eval
  3. Tier1 `skillevaluator quality-check` (+ `validate --no-dedup`) per target
  4. Attempt `validate --full` / Tier3 for Skill Lift (blocked — see above)
  5. Write this doc + improvement backlog into the repos
```

### Orca orchestration shape

| Role | Orca object | Notes |
|------|-------------|-------|
| Coordinator | terminal `skill-eval-coord` | `--from` for Run/task mutations |
| Run | `run_94be10c65fb7` | Objective: SkillEvaluator on three targets |
| Grok worker | worktree `skill-eval-grok`, agent `grok` | Dispatch ready; ran toward Tier1 |
| cursor worker | worktree `skill-eval-cursor`, agent `cursor` | Failed `dispatch_input` / `agent_prompt_stalled` |
| Fallback | host shell SkillEvaluator | Ensured Tier1 scores landed even if TUIs stalled |

Brief used by workers: archived at `~/Work/archive/home-2026-09-07/skill-eval-2026-09-08/BRIEF.md` on mzapan.

## Suggestions to improve

### Skill content (highest leverage for next quality-check)

1. **Frontmatter SKILL_SPEC** — add `version`, `metadata.author` (`Name <email>`), `metadata.tags` (1–5) to every active skill. Unblocks Tier1 schema governance on `--full`.
2. **Shorten `description`** to ~50–150 chars (trigger phrases stay; move long rationale into body).
3. **Add sections** SkillEvaluator expects: `## Purpose`, `## Limitations`, `## Troubleshooting` (Error / Cause / Solution). Optional but lifts Reliability.
4. **`ai-optimization` Correctness (65)** — for hybrid skills, add `## Available Scripts` table and explicit `run_script(...)` examples; keep references one level deep from `SKILL.md`.
5. **`agent-orchestrator`** — flatten nested refs (e.g. `english-procedure.md` depth); keep one-level progressive disclosure.

### Eval / platform (next Skill Lift)

6. **Provider hygiene** — set `SKILL_EVAL_LLM_PROVIDER` explicitly; ensure `OPENAI_API_KEY` is a real OpenAI key (or use `NVIDIA_API_KEY` + `nv_build`). Do not rely on auto-detect when multiple AI keys exist.
7. **Install scanners** for complete Tier1 `--full`: Semgrep, Gitleaks, SkillSpector (quality-check alone skips those gates).
8. **Docker or Harbor** on mzapan for Tier3 with/without-skill arms; until then Skill Lift stays incomplete.
9. **Orca cursor worker** — open/focus the agent TUI before `worker-start`, or `terminal send` after `tui-idle`; headless `--agent cursor` stalled on prompt injection.
10. **Keep Orca serve warm** — `orca serve` dropped between long gaps; compound scripts that create Run + workers in one session are more reliable than separate Shell turns.
11. **Automate** — add a `docs/eval/run-tier1.sh` that loops `quality-check` over a allowlist and writes markdown tables (this pass was hand-orchestrated once).

## Owner / rerun

- Owner: Steward (EM), mzapan-local Orca / Grok / cursor-agent.
- Reminder ops note: Steward box `/workspace/ops/skill-eval/REMINDER.md`.
- Rerun Tier3 only after provider + Docker (or Harbor) are green.

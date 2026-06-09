---
name: finder-reactor
description: Core autonomous, self-guarded decision loop for opportunity-finder apps. Handles discovery (e.g. X search), analysis (LLM + CV + platform context), prep generation, tracking, and guarded promote with cost/rate/fit/CV mutation guards, human pause points, structured decisions, and logging. Use when designing, implementing, or debugging the agentic heart of a finder platform. Fission for tight loops; fusion for reactor architecture and surplus.
---

# Finder Reactor — Self-Guarded, Pause-Aware, Agentic Opportunity Engine

**Core Mission**: Turn raw social/search firehose + user CV + LLM into a reliable, low-intervention personal opportunity system. The finder decides what to pursue, prepares materials, tracks outcomes, and improves itself — while **never** acting on high-stakes things (CV changes to a public profile, expensive runs, low-confidence fits) without explicit guard clearance and user pause points.

## Immutable Principles (Self-Guards Always Win)

1. **Guard > Speed**: No action crosses a threshold (cost, rate remaining, fit score, CV write) without a named guard check + audit log.
2. **Pause for Human on Ambiguity or Stakes**: Low/medium confidence, any CV promote, high token/cost estimates, write side-effects → surface summary + explicit "proceed / tweak / ignore" path.
3. **Full Query + Context Control**: The human/agent always owns the search query. Reactor never hides or hardcodes the "best" search.
4. **Sidecar-First for External Mutation**: CV promote always writes a sidecar proposal first. Master write to the external profile repo is a separate guarded step with diff + confirm.
5. **Structured + Observable Decisions**: Every "decide" call returns machine-readable recommendation + confidence + guard triggers + rationale (zod/serde). UI + MCP + logs expose it.
6. **Surplus After Every Cycle**: After a search-analyze-prep-promote loop, produce at least one concrete improvement that makes the *next* similar loop cheaper or higher-value.
7. **Reversible + Auditable**: All state (leads, preps, decisions) is file-based JSON in app data. CV promotes produce `.bak` + git-friendly diffs.

## Reactor Loop (Conceptual State Machine)

```
Search (tunable query + platform context)
  → Ingest + Classify
  → Analyze (pruned CV packet + platform skill/llms + post → fit, gaps, angle, confidence)
    Guard: cost, rate, basic validity
  → Decide (structured: pursue? score? prep now? pause for user? why?)
  → Prep (if cleared): letter, cv-delta, research, outreach (guarded)
  → Present + Track (UI/MCP)
  → Export / Apply (user or approved agent action)
  → Outcome → Learn
  → Promote (if pattern or explicit): guarded path to external CV repo
  → Surplus
```

Every arrow has a guard or pause hook.

**Pause / Intervention Points** (UI toasts/dialogs + MCP `ask_user` tool):
- Before expensive LLM batch.
- On fit 60–85 or "interesting but stretch".
- Before any promote.
- On rate limit approaching or cost budget hit.
- On low confidence decision.

## Implementation Patterns

**Fission**: Prune CV to "CorePacket"; prune platform posts; token budget on every prompt; structured output schemas.

**Fusion**: Treat as `FinderReactor` state machine; cross-cutting guards (`CVPromoteGuard`, `CostGuard`, `RateGuard`, `DecisionLogger`, `SurplusGenerator`); persist "what worked".

**MCP / Skill Exposure**: Key entry points as MCP tools (`search`, `analyze`, `prep`, `decide`, `promote`). Document in root `SKILL.md` (agentskills.io style).

## Guardrails (Non-Negotiable)

- Never send full raw CV JSON or unpruned threads to LLM unless user explicitly asks for "deep mode" with confirmation.
- Never write to external profile CV without sidecar + preview + two explicit confirms.
- Always surface rate limit headers and estimated spend.
- All autonomous "decide" outputs must include confidence (0–100) and intervention level.
- Reactor dev: follow [bdd-strategizer](../bdd-strategizer/SKILL.md) for guard + pause logic.

## Activation for Agents

- Architecture / new guard design: load finder-reactor + [fusion-sage](../fusion-sage/SKILL.md).
- Specific guard, prompt, or MCP tool: [ai-optimization](../ai-optimization/SKILL.md) + [cv-promote-guard](../cv-promote-guard/SKILL.md), [x-agent-resources](../x-agent-resources/SKILL.md), [tauri-agentic](../tauri-agentic/SKILL.md).
- Parallel Rust vs React vs prompts: [agent-orchestrator](../agent-orchestrator/SKILL.md) + [git-worktrees](../git-worktrees/SKILL.md).

## Surplus Generation (Mandatory After Reactor Changes)

```
⚡ Finder Surplus (Q ≈ X.X)
This change would have [saved Y tokens / avoided Z bad decisions] on recent opportunities.
Concrete future win: [specific example].
Suggested follow-up: [one compounding improvement].
```

Track in `.agents/skills/finder-reactor/surplus-log.md` or fusion-state.

## Related

[x-agent-resources](../x-agent-resources/SKILL.md), [cv-promote-guard](../cv-promote-guard/SKILL.md), [tauri-agentic](../tauri-agentic/SKILL.md), [ai-optimization](../ai-optimization/SKILL.md), [fusion-sage](../fusion-sage/SKILL.md), [agentic-reactor](../agentic-reactor/SKILL.md).

**Example provenance:** battle-tested on [collab-finder](../examples/README.md) — see [examples/README.md](../examples/README.md).

# Skill & workflow quality bar

Library-wide rules for what stays in the active tree.  
Formal kernel: [formal/AppGenMathPhyLang.kernel.md](formal/AppGenMathPhyLang.kernel.md).

## Evaluate every skill edit

```text
Evaluate(δ) ≔ (Correctness, Effectiveness, Efficiency)
Keep / ship ⇔ at least one Δ > 0 for agents that load the skill
```

| Axis | Question |
|------|----------|
| **Correctness** | Does following the skill produce the right outcome / prevent a real failure mode? |
| **Effectiveness** | Does it save future energy (less rediscovery, safer defaults, composable links)? |
| **Efficiency** | Does it cost fewer tokens than the mistakes it prevents? |

## Active skill must have

1. Third-person `description` with **trigger phrases**  
2. **When / skip** clarity  
3. Checkable **done_when** (commands, artifacts, or Card fields)  
4. **Guards / anti-patterns** from real scars — not tool-name lists  
5. Links to related skills (no paste-duplication)  
6. Optional: one control/flow **diagram** when the skill is a state machine or DAG (see [Diagram policy](#diagram-policy))

## Diagram policy

```text
Default:  table or compact ASCII
Mermaid:  only if clarity truly needs it
Never:    decorative diagrams, or diagram + full prose of the same edges
```

| Prefer | When |
|--------|------|
| **Table** | ranks, checklists, decision matrices, phase contracts |
| **ASCII** | simple pipelines, outer SM / small DAG (≲8 nodes), triage forks — always readable as plain text |
| **Mermaid** | multi-actor sequence, gantt/timeline, or dense topology where ASCII becomes unreadable **and** the diagram is the SoT (not a second copy of a table) |

**Bar for mermaid** (all should hold):

1. Graph is non-trivial (many nodes **or** multi-lane / sequence / gantt), **and**  
2. Agent or human would mis-order steps without the topology, **and**  
3. Edges are not already fully stated in an adjacent table/prose block  

**Why (honest):** Agents load skills as text, not a renderer. Small control graphs are clearer and leaner in ASCII; mermaid can help complex flows but is not free tokens and is fragile when invented badly. Diagram policy is hygiene — not a major context-budget lever vs chat history.

Skills and backlog docs (`stellar-spacemap`, etc.) follow the same default; human-facing deliverables may use mermaid when the doc *is* the product and the bar above is met.

## Formal-first progressive disclosure

```text
SKILL.md (formal + mixed English in brackets)  = default agent context
references/english-*.md                        = expand only if formal insufficient
```

Do **not** dual-load both by default.

## Cross-cutting pre-filters (no paste-duplication)

Library-wide hygiene that every heavy skill inherits **by rule**, not by copying tables:

| Concern | On-the-fly rule | SoT depth (only if ambiguous) |
|---------|-----------------|-------------------------------|
| Dual-actor cognitive load (CLT A8) | [rules/clt-dual-load.mdc](rules/clt-dual-load.mdc) (`alwaysApply: true`) | [control-graph/references/clt-load-balance.md](control-graph/references/clt-load-balance.md) |
| Material decision frameworks | [rules/higher-order-decision-architect.mdc](rules/higher-order-decision-architect.mdc) | [higher-order-decision-architect/SKILL.md](higher-order-decision-architect/SKILL.md) |

Necessary orchestration/context skills may add a one-line **CLT:** pointer under Load rule. Domain skills rely on the always-on pre-filter — do **not** re-embed DualLoad tables.

## Not a skill (archive or one-liner)

- Distill stubs: steps = `read_file` / `todo_write` with identical Done-when  
- Session archaeology (“turn 8 evidence”) without portable procedure  
- One-off project incidents better as `examples/` or `archive/`  

Distill install leftovers live under [archive/distill/](archive/distill/README.md).

## Workflows vs skills

| | Skill | Workflow |
|-|-------|----------|
| Unit | Atomic procedure | Ordered multi-agent DAG |
| File | `*/SKILL.md` | `workflows/*.rhai` + optional `.md` |
| Rule | Must be loadable alone | Every phase names a **real** skill path or embeds its non-negotiables |
| Fail | Vague brief | Broken `skill_chain` to missing skills |

## Line budgets (targets)

| Asset | Target |
|-------|--------|
| `SKILL.md` | ≲ 200 lines formal-first |
| Deep detail | `references/` |
| Project-specific | `examples/overlays/` only |

## Rename policy

When renaming (e.g. `looper` → `control-graph`): folder, frontmatter `name`, rules, validators, README index, pack scripts, and description **aliases** for old triggers in one pass.

## Packs (starter)

See root [README.md](README.md). Prefer packs + workflows over “symlink everything.”

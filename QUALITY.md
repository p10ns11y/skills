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
6. Optional: one control/flow **diagram** when the skill is a state machine or DAG  

## Formal-first progressive disclosure

```text
SKILL.md (formal + mixed English in brackets)  = default agent context
references/english-*.md                        = expand only if formal insufficient
```

Do **not** dual-load both by default.

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

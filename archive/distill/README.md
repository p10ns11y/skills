# archive/distill

Session-distilled skills, rules, and workflows installed from agent-prompt-tuning-lab (see prior `.distill-install.json`).

## Why archived

These artifacts were **high-recall of tool sequences**, not battle-tested procedures:

- Identical “Done when” boilerplate  
- Steps that only list tool names (`read_file`, `todo_write`)  
- Workflow `skill_chain` entries pointing at **missing** skills  
- Project-specific phase names (SN cards, nvim snacks, etc.)

They polluted agent discovery without improving Correctness / Effectiveness / Efficiency.

## Layout

| Path | Contents |
|------|----------|
| `skills/` | Thin stub SKILL.md trees |
| `workflows/` | Generated `.md` + `.rhai` pairs + install manifest |
| `rules/` | Thin `.mdc` routers with “evidence: turn N” notes |

## Reuse policy

Do **not** reinstall wholesale. Mine for:

1. A real recurring procedure → rewrite as a proper skill under repo root  
2. A portable multi-phase DAG → rewrite under `workflows/` with **existing** skills  
3. Otherwise leave archived  

## Resurrected (do not use archive copy)

These stubs were rewritten as real formal-first procedures at repo root (QUALITY bar: when/skip, done_when, anti-patterns, composition links). **Archive copies are historical only.**

| Archive stub | Active skill | Scope notes |
|--------------|--------------|-------------|
| `skills/dual-copy-skill-publish` | [../../dual-copy-skill-publish/SKILL.md](../../dual-copy-skill-publish/SKILL.md) | **project-born only**; portable → master-planner symlink |
| `skills/skill-rename-propagation` | [../../skill-rename-propagation/SKILL.md](../../skill-rename-propagation/SKILL.md) | one-pass rename (QUALITY rename policy) |
| `skills/tidy-commit-push` | [../../tidy-commit-push/SKILL.md](../../tidy-commit-push/SKILL.md) | local commit default; push=HITL |
| `skills/adversarial-audit` | [../../adversarial-audit/SKILL.md](../../adversarial-audit/SKILL.md) | refute-first evidence; ≠ Orch VERIFY alone |

Canonical quality bar: [../../QUALITY.md](../../QUALITY.md).

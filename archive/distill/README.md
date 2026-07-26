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

Canonical quality bar: [../../QUALITY.md](../../QUALITY.md).

# odysseus-navigator

**Judgment plane** over [control-graph](../control-graph/SKILL.md) (Outer) and [eva-emptiness](../eva-emptiness/SKILL.md) (Inner): diagnose Odysseus mistakes, prescribe professional antidotes, gate cleverness so the ship still reaches Ithaca.

Agents load **[SKILL.md](SKILL.md)** (formal SoT). Expand [references/english-procedure.md](references/english-procedure.md) only when the formal spec is insufficient. That file also holds the copy-paste system prompt.

## Why

Control-graph keeps the loop deterministic. EVA keeps blank-sheet work from acting on rumor. Neither names the *flavor* of hubris: leaking internals, fashion rewrites, treating prod as disposable, golden-cage complexity, unbounded concurrency, big-bang cutovers, shipping blind.

This skill is that naming — then a hook back to the owner that already runs the graph.

## Quick start

```bash
mkdir -p ~/.cursor/skills ~/.cursor/rules
ln -sfn "$(pwd)/odysseus-navigator" ~/.cursor/skills/odysseus-navigator
ln -sfn "$(pwd)/rules/odysseus-navigator.mdc" ~/.cursor/rules/odysseus-navigator.mdc

node odysseus-navigator/scripts/validate-skill.mjs
```

1. On architecture / plan / advisory work, emit a **Navigator** block (Ithaca, mistakes, waters, spirit, cg_hook, eva_hook, next).
2. Compose with control-graph and eva-emptiness — **do not** inline their bodies.
3. Optional Cursor discovery rule: [../rules/odysseus-navigator.mdc](../rules/odysseus-navigator.mdc).

## Layout

| Path | Purpose |
|------|---------|
| [SKILL.md](SKILL.md) | Formal SoT: axioms, diagnose→prescribe, mistake table, spirits, Navigator emit |
| [references/english-procedure.md](references/english-procedure.md) | Full English + copy-paste system prompt — load only if formal is ambiguous |
| [scripts/validate-skill.mjs](scripts/validate-skill.mjs) | Structural contract check |
| [../rules/odysseus-navigator.mdc](../rules/odysseus-navigator.mdc) | Optional Cursor discovery rule |

## Is / is not

| Is | Is not |
|----|--------|
| **Judgment plane** — mistake, antidote, spirit, Ithaca | Control plane (phases, budgets) |
| Hooks to CG Outer and EVA Inner | A replacement for those skills |
| Procedure + decision tables | A myth lecture or style guide |
| Copy-paste system prompt in English ref | Domain product logic (finder, CV, X) |

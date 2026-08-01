---
name: eva-emptiness
description: >-
  Background Rhai workflow for epistemic emptiness: Prior → Probe → Simulate →
  Score → ActOrAsk. Pairs with the eva-emptiness skill/plugin; does not replace
  interactive /eva.
kind: workflow
skill_chain:
  - eva-emptiness
  - control-graph
---

# eva-emptiness (workflow)

## What this is

A **Grok Build background workflow** (`.rhai`). The host runs phased `agent()` calls; you watch `/workflows`.

It is **not** the same as:

| Thing | Role |
|-------|------|
| Skill `eva-emptiness` | Procedure the model follows (any host) |
| Plugin `eva-emptiness` | Installs skill + `/eva` + prior agents + Bash tether |
| `/eva` | Interactive plan/ask starter (human in the loop) |
| This `.rhai` | Host-scheduled Prior→…→ActOrAsk in the background |

## When

Blank sheet / unknowns dominate / auth unclear. Skip for obvious one-path fixes.

## Install

Plugins do **not** auto-register Rhai. Copy the script:

```bash
# from plugins clone (marketplace extraction)
cp eva-emptiness/.grok/workflows/eva-emptiness.rhai ~/.grok/workflows/
# or project:
# mkdir -p .grok/workflows && cp … .grok/workflows/

# from skills library (same file via symlink once linked)
# cp workflows/eva-emptiness.rhai ~/.grok/workflows/
```

Discovery roots (official): project `<repo>/.grok/workflows/*.rhai`, user `~/.grok/workflows/*.rhai`. Filename should match `meta.name` (`eva-emptiness`).

## Launch

```text
/workflow eva-emptiness {"goal":"Decide whether to introduce feature flags for billing v2 with no prior design doc"}
```

Dashboard: `/workflows` — pause / resume / stop by display name.

## Suggest chain

| After this workflow… | Suggest |
|----------------------|---------|
| Act path needs multi-worker delivery | `/workflow multi-agent-delivery` |
| Repo is large / cold context | `/workflow context-ignite` |
| Need claim-checked research | `/deep-research …` (built-in) |
| Human must stay on every gate | use `/eva` instead of (or before) this workflow |

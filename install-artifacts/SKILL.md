---
name: install-artifacts
description: Copy rules/skills bundles into target .agents/ folder via pnpm script; supports bundle and target flags
---

# install-artifacts

## When to use

Copy rules/skills bundles into target .agents/ folder via pnpm script; supports bundle and target flags

## Composability

- mode: `workflow`
- evidence: turns 21-23 tool_sequence and usage docs

## Steps

1. Grep repo conventions
2. Write scripts/install-artifacts.mjs
3. StrReplace update paths to .agents
4. Shell test pnpm install-artifacts

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

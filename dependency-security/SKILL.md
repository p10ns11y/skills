---
name: dependency-security
description: when performing pnpm audit fixes, deprecation removal, supply-chain hardening with sfw; agent-agnostic under .agents/skills/
---

# dependency-security

## When to use

when performing pnpm audit fixes, deprecation removal, supply-chain hardening with sfw; agent-agnostic under .agents/skills/

## Composability

- mode: `workflow`
- evidence: turns 3-4,5,8: created .agents/skills/dependency-security/SKILL.md then applied to workspace

## Steps

1. read pnpm-workspace.yaml and package.json
2. run pnpm audit
3. apply sfw-wrapped install
4. update allowedDeprecatedVersions and overrides

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

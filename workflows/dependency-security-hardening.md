---
name: dependency-security-hardening
description: end-to-end workflow to move pnpm settings, audit/fix vulns, create reusable skills, harden workspace with max supply-chain rules, perform safe upgrades and commit
kind: workflow
skill_chain: ["dependency-security", "upgrade-packages", "trust-policy-resolution"]
---

# dependency-security-hardening

end-to-end workflow to move pnpm settings, audit/fix vulns, create reusable skills, harden workspace with max supply-chain rules, perform safe upgrades and commit

## Skill chain

1. `dependency-security`
2. `upgrade-packages`
3. `trust-policy-resolution`

## Phases

### Explore

read package.json, pnpm-workspace.yaml, run pnpm audit

### Skill Authoring

create .agents/skills/ for security and upgrades

### Apply & Harden

update workspace, run sfw installs, bump packages

### Commit

branch + commit with skill and config changes

## Support

- sessions: 1
- rank: 30

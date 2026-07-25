---
name: prompt-artifact-ingest
description: Harvest raw sessions, filter by split/repo, derive skills/rules, generate installable bundles, and publish via .agents/ installer
kind: workflow
skill_chain: ["harvest-conversations", "suggest-artifacts", "install-artifacts"]
---

# prompt-artifact-ingest

Harvest raw sessions, filter by split/repo, derive skills/rules, generate installable bundles, and publish via .agents/ installer

## Skill chain

1. `harvest-conversations`
2. `suggest-artifacts`
3. `install-artifacts`

## Phases

### Explore & Evaluate

Check TOON vs JSONL and repo data shapes

### Harvest

Extract 1273 turns across repos with path preservation

### Derive

Produce high-signal skills/rules and avoid pitfalls

### Package & Install

Create installer script and inverted gitignore

## Support

- sessions: 1
- rank: 30

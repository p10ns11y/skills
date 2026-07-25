---
name: suggest-artifacts
description: Ingest latest draft or filtered sessions into existing skill/rule drafts using bundle-targets mapping
---

# suggest-artifacts

## When to use

Ingest latest draft or filtered sessions into existing skill/rule drafts using bundle-targets mapping

## Composability

- mode: `workflow`
- evidence: turn 42 commit message listing suggest-artifacts and bundle-targets

## Steps

1. Task background worker
2. Read bundle-targets.json
3. Write PROMPT_MODE.md

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

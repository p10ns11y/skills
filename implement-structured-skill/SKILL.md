---
name: implement-structured-skill
description: when authoring a new agent skill: read plan, seed todos, write SKILL.md + rule + validation script then update indexes
---

# implement-structured-skill

## When to use

when authoring a new agent skill: read plan, seed todos, write SKILL.md + rule + validation script then update indexes

## Composability

- mode: `workflow`
- evidence: turns 4-5: read plan, todo_write, write loops-manager files, then index

## Steps

1. read_file
2. todo_write
3. write
4. search_replace

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

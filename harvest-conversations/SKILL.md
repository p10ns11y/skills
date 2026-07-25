---
name: harvest-conversations
description: Run and fix extraction scripts to pull turns from all repos including subagents while preserving paths
---

# harvest-conversations

## When to use

Run and fix extraction scripts to pull turns from all repos including subagents while preserving paths

## Composability

- mode: `workflow`
- evidence: turn 2 tool_sequence + narrative on fixing harvest unpack and devcontainer trap bug

## Steps

1. Read harvest scripts
2. Shell run extraction
3. StrReplace fix traps/paths
4. Glob/Read verify output

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

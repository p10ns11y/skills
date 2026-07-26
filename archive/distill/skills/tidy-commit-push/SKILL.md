---
name: tidy-commit-push
description: Inspect, clean legacy files, verify privacy, then commit and push with conventional message
---

# tidy-commit-push

## When to use

Inspect, clean legacy files, verify privacy, then commit and push with conventional message

## Composability

- mode: `workflow`
- evidence: turn 5 and 10 tool sequences

## Steps

1. run_terminal_command status/clean
2. write/search_replace tidy
3. run_terminal_command commit-push

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

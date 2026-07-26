---
name: adversarial-audit
description: Systematically read modules, grep for mappings, run tests, and capture evidence of bugs or leaks before verdict
---

# adversarial-audit

## When to use

Systematically read modules, grep for mappings, run tests, and capture evidence of bugs or leaks before verdict

## Composability

- mode: `workflow`
- evidence: tool_sequence: read_file, grep, run_terminal_command, write across turns 3 and 6

## Steps

1. read shipped files
2. grep wiring and approvals
3. run tests
4. write verdict

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

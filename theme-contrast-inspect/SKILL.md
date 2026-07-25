---
name: theme-contrast-inspect
description: Read theme CSS, delta config and systemd units then identify low-contrast or conflicting tokens before patching
---

# theme-contrast-inspect

## When to use

Read theme CSS, delta config and systemd units then identify low-contrast or conflicting tokens before patching

## Composability

- mode: `workflow`
- evidence: turns 4,5,8,9 repeatedly use read+grep+run before any search_replace

## Steps

1. read_file on relevant css/unit files
2. grep for palette or timer entries
3. run_terminal_command to test rendering

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

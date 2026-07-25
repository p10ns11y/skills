---
name: inspect-theme-config
description: Read delta/git/waybar configs and eye-comfort tokens before any rendering or palette change
---

# inspect-theme-config

## When to use

Read delta/git/waybar configs and eye-comfort tokens before any rendering or palette change

## Composability

- mode: `workflow`
- evidence: turn 4 tool sequence + narrative cue about loading eye-comfort tokens

## Steps

1. read_file
2. grep
3. run_terminal_command

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

---
name: waybar-tooltip-light-fix
description: Replace dark-only Pango tokens with light-aware palette in tooltip CSS
---

# waybar-tooltip-light-fix

## When to use

Replace dark-only Pango tokens with light-aware palette in tooltip CSS

## Composability

- mode: `workflow`
- evidence: turn 9 root-cause + search_replace sequence

## Steps

1. identify tooltip rule
2. search_replace palette values
3. test light theme rendering

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

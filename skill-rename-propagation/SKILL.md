---
name: skill-rename-propagation
description: rename skill folder/rule/index everywhere then update both library and consuming repo
---

# skill-rename-propagation

## When to use

rename skill folder/rule/index everywhere then update both library and consuming repo

## Composability

- mode: `workflow`
- evidence: turns 6-7,15,17-18: grep, search_replace, run_terminal_command

## Steps

1. grep for old name
2. search_replace in SKILL.md/rule/index/validator
3. run validation
4. commit both repos

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

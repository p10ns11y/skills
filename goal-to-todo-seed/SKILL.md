---
name: goal-to-todo-seed
description: Read goal plan then immediately call todo_write before any code changes
---

# goal-to-todo-seed

## When to use

Read goal plan then immediately call todo_write before any code changes

## Composability

- mode: `workflow`
- evidence: turns 3 and 8: read_file + todo_write + update_goal sequence

## Steps

1. read_file goal
2. todo_write from acceptance criteria
3. update_goal after milestones

## Done when

Outputs are ready for the next skill in a parent workflow, or the user goal is met.

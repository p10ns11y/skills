---
name: explore-repo-readonly
description: Readonly exploration of a C/C++ or CMake repo before MVU or structural changes. Use when user asks to explore and report structure, CMake support, or elomaxz integration points.
---

# Explore repo (readonly)

## When to use

- Before CMake + MVU refactor when structure is unknown
- User wants report only, not implementation yet
- Parent delegates readonly survey to a subagent

## Return format

1. **Layout** — key dirs (`src/`, `cmake/`, models, tests)
2. **Build** — how to configure and build today
3. **MVU / model hooks** — where state and update live (file:line references)
4. **Gaps** — what the plan must add vs what exists
5. **Risks** — ColumnLimit, single-file god modules, missing tests

## Procedure

Glob → Grep → Read — **no Write** unless user escalates to implement.

Keep paths relative; use `{REPO_ROOT}` in exported notes.

## Handoff

Parent session uses this report to drive [mvu-refactor-plan](../mvu-refactor-plan/SKILL.md).

**Example provenance:** [premflow](../examples/README.md).

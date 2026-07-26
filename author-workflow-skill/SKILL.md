---
name: author-workflow-skill
description: Create a new project SKILL.md for a repeatable workflow. Use when user asks to add a skill for vulnerabilities, package upgrades, audits, supply-chain checks, or any named agent workflow.
---

# Author a workflow skill

## When to use

User requests: "Add a SKILL.md for …", "create a skill to …", or describes a repeatable procedure worth attaching on demand.

## Steps

1. **Glob** existing `.cursor/skills/` and `.agents/skills/` — match naming and frontmatter style.
2. **Read** 1–2 existing SKILL.md files in the repo for tone and section layout.
3. Draft skill with:
   - YAML `name` + `description` (third person; include trigger phrases)
   - **Formal-first body** (optional dense header per [formal/AppGenMathPhyLang.kernel.md](../formal/AppGenMathPhyLang.kernel.md); English in `(parentheses)` where a symbol may confuse)
   - **When to use / skip** — bullet triggers
   - **Steps** — ordered, tool-friendly; one diagram if state machine/DAG
   - **Done when** — verifiable exit criteria (commands/artifacts)
   - **references/english-*.md** — full plain English; agent loads **only if** formal SoT is insufficient
4. **Write** under `.agents/skills/<name>/SKILL.md` (or project convention path).
5. Optionally add a **routing rule** (`.mdc`) telling the agent when to suggest attaching the skill.
6. Meet [QUALITY.md](../QUALITY.md) — no tool-name-only stubs.

## Do not

- Paste long policy essays — skills are procedures, not style guides
- Dual-load formal + full English by default (token waste)
- Duplicate an existing skill — extend or link instead
- Commit secrets or environment-specific paths — use `{REPO_ROOT}` placeholders
- Ship distill “evidence: turn N” archaeology as a skill

## Validate

Ask user to invoke `/skill-name` on the next matching task; compare tool pattern to gold sessions (Read → research → Shell verify).

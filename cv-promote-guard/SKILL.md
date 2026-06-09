---
name: cv-promote-guard
description: Strict self-guarded mechanism for reading an external CV source (e.g. cvdata.json in a portfolio repo) for grounding and safely promoting insights back with sidecars, diffs, previews, backups, and explicit user confirmation. Never mutates external profile without multiple gates. Use for CV-related logic in finder-reactor or prep flows. Sidecar-first, auditable, intervention points. Fission for safe edit code; fusion for protecting the public profile while improving future matches.
---

# CV Promote Guard — Safe, Auditable, Sidecar-First Profile Evolution

**Core Mission**: Allow opportunity finders to use the user's real CV for hyper-relevant analysis and prep, while making any "promote insights" (suggested improvements to headline, experience bullets, skills, etc.) completely safe, reversible, and user-controlled.

## Immutable Principles

1. **Sidecar-First Always**: All proposed changes go to a sidecar (e.g. `preps/<id>/cv-delta.json`) before any master edit.
2. **External Repo is Sacred**: The configured profile checkout is read-only by default. Writes require multi-step confirmation + diff preview.
3. **Multiple Guards & Pauses**: prune on read; diff preview + `.bak` on promote; extra pause for public-facing fields.
4. **Full Audit & Reversible**: Log source opportunity, rationale, deltas, user decision. Git-friendly patch output.
5. **Composability**: Exposed as guarded MCP tool — agents suggest, never force promotes.

## Reactor Integration

In finder-reactor loop:
- Analyze/Prep: load pruned CV packet from configured `cv_repo_path` (e.g. `src/data/cvdata.json`).
- Promote flow: generate delta → sidecar → preview → confirm → safe write + backup.
- Guard triggers: "Is this promoting to live public CV? Pause."

## Implementation Patterns

**Loading & Pruning (Fission)**:
- Config: `cv_repo_path` (user picks once, stored securely).
- Prune: relevant sections only (recent roles matching keywords, top projects, skills, headline, contact).
- Never send full multi-hundred-line JSON to LLM by default.

**Preview & Apply**:
- Desktop UI: diff viewer with checkboxes per edit.
- MCP: `promote_with_preview(insights)` → diff + requires confirm.
- On apply: backup (`cvdata.json.bak-<ts>`), apply edits (json-patch or manual), return rebuild instructions for the portfolio repo.

## Guardrails

- No direct mutation of external CV without this guard module.
- Always produce sidecar proposal even for internal suggestions.
- User can configure "never auto-write", "always require 2 confirms", "dry-run only".
- On error: rollback from `.bak`.

## Related Skills

[finder-reactor](../finder-reactor/SKILL.md), [x-agent-resources](../x-agent-resources/SKILL.md), [tauri-agentic](../tauri-agentic/SKILL.md), [ai-optimization](../ai-optimization/SKILL.md), [fusion-sage](../fusion-sage/SKILL.md).

**Example provenance:** [collab-finder](https://github.com/p10ns11y/collab-finder) + [devprofile](https://github.com/p10ns11y/devprofile) CV repo pattern.

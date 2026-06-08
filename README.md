# skills

A personal library of high-signal, reusable **skills** for Grok, Cursor, and other agentic coding environments.

Each subdirectory is a self-contained skill defined by a `SKILL.md`. Skills encode battle-tested procedures, domain expertise, guardrails, and workflows so agents can reliably tackle complex, recurring work.

## Philosophy

- **Fission** (efficiency): Ruthlessly prune context to the minimal relevant surface. See [ai-optimization](ai-optimization/SKILL.md) ("Context Sage").
- **Fusion + Surplus** (power + compounding returns): After pruning, synthesize higher-order abstractions and generate concrete improvements that make *future* similar work cheaper. See [fusion-sage](fusion-sage/SKILL.md).
- **Safe orchestration**: Complex work uses briefs, isolated workspaces (git worktrees or sandboxes), independent verification, and clean merge discipline — never `cp`.
- **Self-guarded autonomy**: Core loops (especially around opportunity finding, profile mutation, and agent actions) include explicit cost/rate/fit/CV guards + human pause points.
- **Portable but opinionated**: Many skills were hardened on real projects (collab-finder, devprofile, premflow) but are designed for reuse.

## Installation / Activation

Skills live wherever your agent looks for them:

- **Grok**: `~/.grok/skills/<name>/SKILL.md` (or symlinked)
- **Cursor**: `.cursor/skills/<name>/` (or symlinked into the project or global)
- **Project-local**: `.agents/skills/<name>/SKILL.md` (common pattern; referenced from `AGENTS.md`)

Typical flow (from a canonical checkout of this repo):

```bash
# Example: make key skills available to Grok
mkdir -p ~/.grok/skills
ln -s "$(pwd)/ai-optimization" ~/.grok/skills/ai-optimization
ln -s "$(pwd)/fusion-sage"      ~/.grok/skills/fusion-sage
ln -s "$(pwd)/agent-orchestrator" ~/.grok/skills/agent-orchestrator
ln -s "$(pwd)/git-worktrees"    ~/.grok/skills/git-worktrees
# ... add others as needed
```

In target projects, an `AGENTS.md` (or Cursor rule) usually declares the active skill set and any project-specific extensions.

Some skills also ship supporting material:
- Scripts under `scripts/`
- References, templates, schemas, or data under `references/`, `templates/`, `assets/`
- Companion `.mdc` rules (for Cursor "always apply")

## Skills

### Agent Orchestration & Execution

| Skill | One-liner |
|-------|-----------|
| [agent-orchestrator](agent-orchestrator/SKILL.md) | Triage single-shot vs. full orchestration. Writes briefs, manages worktrees/sandboxes, verifies independently, integrates cleanly. |
| [concurrent-cli-agents](concurrent-cli-agents/SKILL.md) | Run multiple agents (Hermes, Grok, etc.) safely in parallel on isolated worktrees or cloud sandboxes. |
| [git-worktrees](git-worktrees/SKILL.md) | Effective, safe git worktree usage for agents + disk hygiene for `~/.grok/worktrees/`. Commit-then-merge only. |
| [split-to-prs](split-to-prs/SKILL.md) | Break a body of work (chat, branch, or PR) into small, reviewable PRs. |
| [subagent-delegation](subagent-delegation/SKILL.md) | Delegate broad readonly exploration with a strict return format. |
| [subagent-explore-report](subagent-explore-report/SKILL.md) | Structured readonly repo survey (especially for CMake/MVU work). |

### Context, Intelligence & Reactors

| Skill | One-liner |
|-------|-----------|
| [ai-optimization](ai-optimization/SKILL.md) | Fission engine: relevance scoring, language-native compression, strict token budgets, progressive disclosure. |
| [fusion-sage](fusion-sage/SKILL.md) | Fusion reactor on top of fission: cross-file synthesis, surplus generation (Q>1 improvements), evolving knowledge graphs, self-amplification. |
| [finder-reactor](finder-reactor/SKILL.md) | Core autonomous, self-guarded opportunity engine (X search + analysis + prep + promote with cost/rate/fit/CV guards + pauses). |
| [agentic-reactor](agentic-reactor/SKILL.md) | Overarching patterns for self-guarded, pause-aware, living agent platforms (combines finder + shell + X + CV guard + MCP). |

### Platform, Desktop & Tooling

| Skill | One-liner |
|-------|-----------|
| [tauri-agentic](tauri-agentic/SKILL.md) | Build agentic, MCP-exposed, self-guarded Tauri desktop apps (Rust backend + React/TS). Command palette as agent UI. |
| [tauri-ipc-debug](tauri-ipc-debug/SKILL.md) | Systematic debugging of Tauri IPC layers (MVU → safeInvoke → Rust → storage/X). |
| [devcontainer-hardened](devcontainer-hardened/SKILL.md) | Generate minimal, security-hardened `.devcontainer` configs (pinned digests, non-root, capability drops). |
| [project-editor-profile](project-editor-profile/SKILL.md) | Generate editor settings (VS Code / Cursor) from a portable `.editor/profile.json` manifest. |

### Frontend & UI

| Skill | One-liner |
|-------|-----------|
| [react-client-expert](react-client-expert/SKILL.md) | Senior client-side React patterns (minimal state, deliberate effects, Suspense + TanStack Query, XState, accessibility). |
| [semantic-markup-css](semantic-markup-css/SKILL.md) | Modern semantics, ARIA, contrast, data-* states, native elements + Tailwind where it wins. |

### X / Social Data & Profile Safety

| Skill | One-liner |
|-------|-----------|
| [x-agent-resources](x-agent-resources/SKILL.md) | Correct use of official X Developer Platform primitives (llms.txt, skill.md, MCP, xurl, OpenAPI) for agents. |
| [cv-promote-guard](cv-promote-guard/SKILL.md) | Strict, auditable, sidecar-first guards for reading a dev CV and safely promoting derived insights back to a public profile. |

### Maintenance, Security & Supply Chain

| Skill | One-liner |
|-------|-----------|
| [supply-chain-harden](supply-chain-harden/SKILL.md) | pnpm workspace hardening, audits, deprecations, Socket Firewall (sfw) integration. |
| [fix-dependency-security](fix-dependency-security/SKILL.md) | Fix vulns/deprecations + safe upgrade patterns. |
| [upgrade-packages](upgrade-packages/SKILL.md) | Safe major/minor/patch upgrades with codemods where available. |
| [audit-allow-builds](audit-allow-builds/SKILL.md) | Audit `allowBuilds` / lifecycle scripts in the pnpm lockfile. |
| [audit-ide-dependencies](audit-ide-dependencies/SKILL.md) | Audit Cursor/VS Code extensions and their bundled deps. |

### Strategy & Authoring

| Skill | One-liner |
|-------|-----------|
| [bdd-strategizer](bdd-strategizer/SKILL.md) | Core-first BDD/TDD decomposition for large refactors and legacy work. |
| [author-workflow-skill](author-workflow-skill/SKILL.md) | Create new well-formed `SKILL.md` files for repeatable workflows. |

### Specialized / Niche

| Skill | One-liner |
|-------|-----------|
| [cursor-transcript-harvest](cursor-transcript-harvest/SKILL.md) | Harvest Cursor agent sessions for prompt tuning / gold data. |
| [explore-repo-readonly](explore-repo-readonly/SKILL.md) | Safe pre-change exploration of complex codebases (CMake, MVU, etc.). |
| [mvu-refactor-plan](mvu-refactor-plan/SKILL.md) | Planning and execution of CMake + elomaxz MVU refactors. |
| [src-tree-reorganize](src-tree-reorganize/SKILL.md) | Move scattered sources under `src/` with build system updates. |

## Contributing / Extending

- Follow the tone and structure of existing high-quality skills (frontmatter with `name` + `description`, clear triggers, ordered steps, guardrails, verification).
- Use [author-workflow-skill](author-workflow-skill/SKILL.md) when creating a new one.
- Prefer linking to existing skills over duplication.
- Keep descriptions in the frontmatter trigger-oriented (the agent uses them for routing).

## Related

- User's main project `AGENTS.md` (rules, active skills, verification commands, E2E notes).
- `fusion-sage/fusion-state.*` and surplus logs for persistent cross-session intelligence.
- Individual skill READMEs and `references/` for deeper domain playbooks.

---

**Fission keeps you fast. Fusion makes you unstoppable.**
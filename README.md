# Agent Skills Library

**After losing and winning many battles — and winning the war — these are the playbooks that survived.**

Not blog-post advice. Not "best practices" copied from docs. Each skill here is a scar from something that actually broke: agents that overwrote each other's work, context windows that ate the budget before the fix landed, a CV promote that almost hit production, supply-chain installs that looked clean until they weren't. The wins got encoded. The losses became guardrails.

This is a library of [Cursor Agent Skills](https://cursor.com/docs/context/skills) (also usable with Grok, Continue, and other agentic tools) for **token-efficient context**, **safe multi-agent orchestration**, **supply-chain hardening**, and **self-guarded autonomous workflows**.

Each directory is a self-contained skill with a `SKILL.md` frontmatter (`name`, `description`) that agents use for discovery and routing.

## Why these skills exist

Most agent failures are not model failures. They are **context**, **coordination**, and **guardrail** failures — the kind you only recognize after you've paid for them once.


| Problem | What we lost | What the skill encodes |
| ------- | ------------ | ---------------------- |
| Context window bloat on large repos | Hours re-explaining the same codebase every turn | [ai-optimization](ai-optimization/SKILL.md) — relevance scoring, compression, strict budgets |
| One-shot help that doesn't compound | Same architectural mistakes, session after session | [fusion-sage](fusion-sage/SKILL.md) — synthesis + surplus (Q > 1 improvements) |
| Parallel agents overwriting each other | Merged garbage, lost work, `cp` disasters | [git-worktrees](git-worktrees/SKILL.md) + [agent-orchestrator](agent-orchestrator/SKILL.md) |
| Unsafe autonomous actions | Near-misses on CV writes, runaway API spend | [finder-reactor](finder-reactor/SKILL.md) + [cv-promote-guard](cv-promote-guard/SKILL.md) |
| npm supply-chain risk | "Audit clean" installs that still weren't safe | [fix-dependency-security](fix-dependency-security/SKILL.md) + [supply-chain-harden](supply-chain-harden/SKILL.md) |
| Leaving the agent to jot a note | Broken flow, forgotten captures | [premflow](premflow/SKILL.md) skill → full plugin at `https://github.com/p10ns11y/plugins` (premflow/) (`/note` `/focus` `/journal`) |

**Philosophy:** Fission keeps you fast. Fusion makes you unstoppable. Guards are what you add after you almost didn't need them.

---

## Quick start

### 1. Clone

```bash
git clone <this-repo> ~/skills   # or fork and clone yours
cd ~/skills
```

### 2. Install for Cursor

**Global** (available in every project):

```bash
mkdir -p ~/.cursor/skills
for skill in ai-optimization fusion-sage agent-orchestrator looper git-worktrees master-planner; do
  ln -sf "$(pwd)/$skill" ~/.cursor/skills/$skill
done
# optional rules (alwaysApply: false)
ln -sf "$(pwd)/rules/looper.mdc" ~/.cursor/rules/looper.mdc 2>/dev/null || true
ln -sf "$(pwd)/rules/master-planner.mdc" ~/.cursor/rules/master-planner.mdc 2>/dev/null || true
```

**Per-project** (share with teammates via repo):

```bash
mkdir -p .cursor/skills
ln -sf /path/to/skills/ai-optimization .cursor/skills/ai-optimization
```

Cursor discovers skills from `~/.cursor/skills/` and `.cursor/skills/`. The agent loads them when the task matches the skill's `description`.

### 3. Install for Grok / other agents

```bash
mkdir -p ~/.grok/skills
ln -sf "$(pwd)/ai-optimization" ~/.grok/skills/ai-optimization
# repeat for skills you need
```

Point your project's `AGENTS.md` (or equivalent) at the active skill set and verification commands.

### 4. Optional — project overlays

Skills are **portable by default**. Repo-specific tuning (relevance scoring, fusion targets, devcontainer starters) lives in [examples/](examples/README.md) — copy overlays into your project rather than editing skill bodies.

---

## Recommended starter packs

Pick a pack, symlink those skills, add more as needed.


| Pack                            | Skills                                                                                        | Best for                           |
| ------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------------------- |
| **Context & speed**             | `ai-optimization`, `fusion-sage`                                                              | Large codebases, expensive context |
| **Multi-agent delivery**        | `agent-orchestrator`, `looper`, `git-worktrees`, `concurrent-cli-agents`, `split-to-prs`      | Parallel agents, structured loops, PR hygiene |
| **Node supply chain**           | `fix-dependency-security`, `upgrade-packages`, `audit-allow-builds`, `supply-chain-harden`    | pnpm monorepos, CI hardening       |
| **React / Next frontend**       | `react-client-expert`, `semantic-markup-css`, `project-editor-profile`                        | App Router, a11y, editor sync      |
| **Opportunity finder platform** | `finder-reactor`, `agentic-reactor`, `x-agent-resources`, `cv-promote-guard`, `tauri-agentic` | Tauri + X + LLM autonomous loops   |
| **C / CMake / MVU**             | `explore-repo-readonly`, `mvu-refactor-plan`, `src-tree-reorganize`                           | elomaxz-style refactors            |
| **Strategy & decisions**        | `higher-order-decision-architect`, `bdd-strategizer`, `stellar-roadmap`                       | Architecture tradeoffs, backlog docs, blueprint cards |
| **Master plan / skill packs**   | `master-planner` (+ pack it selects)                                                          | Pull/tweak skills for cwd; Orwell overlays; project ontology |
| **Shell verify workflow**       | `verification-cockpit`, `shell-kernel-ontology`, `stellar-roadmap`, `ai-optimization`, `fusion-sage` | `av` tmux cockpits, kernel ontology graph, `coming-next.md` roadmaps |


---

## Skill catalog

### Agent orchestration & execution


| Skill                                                       | One-liner                                                                                          |
| ----------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| [agent-orchestrator](agent-orchestrator/SKILL.md)           | Triage single-shot vs full orchestration; briefs, worktrees, independent verification, clean merge |
| [looper](looper/SKILL.md)                                   | Structured agent loops: outer state machine, budgets, HITL gates, multi-model routing over raw ReAct |
| [concurrent-cli-agents](concurrent-cli-agents/SKILL.md)     | Run multiple CLI agents safely on isolated worktrees or sandboxes                                  |
| [git-worktrees](git-worktrees/SKILL.md)                     | Safe git worktree usage for agents; commit-then-merge; disk hygiene                                |
| [gt-flow](gt-flow/SKILL.md)                                 | When to use Graphite (`gt`) vs plain branches with agent worktrees                                 |
| [split-to-prs](split-to-prs/SKILL.md)                       | Split a body of work into small, reviewable PRs                                                    |
| [subagent-delegation](subagent-delegation/SKILL.md)         | Delegate readonly exploration with a strict return format                                          |
| [subagent-explore-report](subagent-explore-report/SKILL.md) | Structured readonly repo survey (CMake/MVU, etc.)                                                  |


### Context, intelligence & reactors


| Skill                                       | One-liner                                                                               |
| ------------------------------------------- | --------------------------------------------------------------------------------------- |
| [ai-optimization](ai-optimization/SKILL.md) | Fission engine: relevance scoring, compression, token budgets, progressive disclosure   |
| [fusion-sage](fusion-sage/SKILL.md)         | Fusion on fission: synthesis, surplus (Q>1), knowledge graph, self-amplification        |
| [finder-reactor](finder-reactor/SKILL.md)   | Self-guarded opportunity engine: search → analyze → prep → promote with guards & pauses |
| [agentic-reactor](agentic-reactor/SKILL.md) | Glue patterns for pause-aware autonomous platforms (finder + shell + MCP)               |


### Platform, desktop & tooling


| Skill                                                     | One-liner                                                                      |
| --------------------------------------------------------- | ------------------------------------------------------------------------------ |
| [tauri-agentic](tauri-agentic/SKILL.md)                   | Agentic Tauri apps: MCP tools, command palette, guards in Rust + React         |
| [tauri-ipc-debug](tauri-ipc-debug/SKILL.md)               | Systematic Tauri IPC triage (MVU → invoke → Rust → storage/API)                |
| [devcontainer-hardened](devcontainer-hardened/SKILL.md)   | Minimal hardened `.devcontainer` configs (pinned digests, non-root, cap drops) |
| [project-editor-profile](project-editor-profile/SKILL.md) | Generate VS Code/Cursor settings from `.editor/profile.json`                   |
| [chrome-extension-mv3](chrome-extension-mv3/SKILL.md)     | MV3 extensions: service worker, message passing, content scripts, permissions |


### Frontend & UI


| Skill                                               | One-liner                                                                   |
| --------------------------------------------------- | --------------------------------------------------------------------------- |
| [react-client-expert](react-client-expert/SKILL.md) | Senior React client patterns: minimal state, Suspense + Query, XState, a11y |
| [semantic-markup-css](semantic-markup-css/SKILL.md) | Semantics, ARIA, contrast, native elements + Tailwind where CSS wins        |


### X / social data & profile safety


| Skill                                           | One-liner                                                                     |
| ----------------------------------------------- | ----------------------------------------------------------------------------- |
| [x-agent-resources](x-agent-resources/SKILL.md) | Official X Developer Platform primitives (llms.txt, skill.md, MCP, xurl)      |
| [cv-promote-guard](cv-promote-guard/SKILL.md)   | Sidecar-first, auditable guards for CV read/promote to external profile repos |


### Maintenance, security & supply chain


| Skill                                                       | One-liner                                                 |
| ----------------------------------------------------------- | --------------------------------------------------------- |
| [supply-chain-harden](supply-chain-harden/SKILL.md)         | pnpm workspace hardening, audits, Socket Firewall (`sfw`) |
| [fix-dependency-security](fix-dependency-security/SKILL.md) | Fix vulns/deprecations with safe upgrade patterns         |
| [upgrade-packages](upgrade-packages/SKILL.md)               | Safe major/minor/patch upgrades with codemods             |
| [audit-allow-builds](audit-allow-builds/SKILL.md)           | Audit `allowBuilds` / lifecycle scripts in pnpm lockfile  |
| [audit-ide-dependencies](audit-ide-dependencies/SKILL.md)   | Audit Cursor/VS Code extensions and bundled deps          |


### Strategy & authoring


| Skill                                                   | One-liner                                            |
| ------------------------------------------------------- | ---------------------------------------------------- |
| [master-planner](master-planner/SKILL.md)               | Master plan = friction-removing automation web; scan library, pull pack, Orwell-tweak overlays, ontology for complex repos |
| [bdd-strategizer](bdd-strategizer/SKILL.md)             | Core-first BDD/TDD decomposition for large refactors |
| [author-workflow-skill](author-workflow-skill/SKILL.md) | Author new well-formed `SKILL.md` files              |
| [higher-order-decision-architect](higher-order-decision-architect/SKILL.md) | First-principles decision framework before material architecture/API/security choices |
| [stellar-roadmap](stellar-roadmap/SKILL.md) | Evidence-driven architecture backlog docs: scorecards, SN-* blueprint cards, gantt order |


### Shell workflow & verification


| Skill                                                       | One-liner                                                                                          |
| ----------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| [verification-cockpit](verification-cockpit/SKILL.md)       | Generate per-project `.agents/verification/` tmux cockpits for `av`-style verify workflows       |
| [shell-kernel-ontology](shell-kernel-ontology/SKILL.md)       | Route edits across shellyxz kernel ontology subgraphs (PATH, boundary, verify bridge, drift gate) |


### Specialized


| Skill                                                           | One-liner                                              |
| --------------------------------------------------------------- | ------------------------------------------------------ |
| [cursor-transcript-harvest](cursor-transcript-harvest/SKILL.md) | Harvest Cursor sessions for prompt tuning / eval data  |
| [explore-repo-readonly](explore-repo-readonly/SKILL.md)         | Safe pre-change exploration of complex codebases       |
| [mvu-refactor-plan](mvu-refactor-plan/SKILL.md)                 | CMake + elomaxz MVU refactor planning and execution    |
| [src-tree-reorganize](src-tree-reorganize/SKILL.md)             | Move scattered sources under `src/` with build updates |


---

## Where these were forged

These skills weren't designed in a vacuum. They were **extracted from real projects after the fighting stopped** — [devprofile](https://github.com/p10ns11y/devprofile), [collab-finder](https://github.com/p10ns11y/collab-finder), [premflow](https://github.com/thecuriousts/premflow), [sorkalam-extension](https://github.com/p10ns11y/sorkalam-extension), and the harvest pipeline in [agent-prompt-tuning-lab](https://github.com/p10ns11y/agent-prompt-tuning-lab) — each with its own stack, its own failures, its own fixes that held up under pressure.

Project names and repo-specific paths live in [examples/README.md](examples/README.md), not in skill bodies. You get the portable lesson; the war stories stay in the footnotes.


| Project           | Stack                                                              | Primary skills                                                      |
| ----------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------- |
| [**devprofile**](https://github.com/p10ns11y/devprofile)    | Next.js 16, Biome, Tailwind v4, host-browser E2E, CV/PDF, X post search picker, xAI API, xAI collections (embedded datasets) | Context, fusion, frontend, devcontainer, supply chain               |
| [**collab-finder**](https://github.com/p10ns11y/collab-finder) | Tauri 2, Rust reactor, React, X API + LLM, MCP, SQLite             | Finder reactor, Tauri agentic, X resources, CV guard, git worktrees |
| [**premflow**](https://github.com/thecuriousts/premflow)      | C, CMake, elomaxz MVU                                              | MVU refactor, readonly explore, src reorganize                      |
| [**sorkalam-extension**](https://github.com/p10ns11y/sorkalam-extension) | MV3 Chrome extension, vanilla JS, Wiktionary + Tamil VU glossary   | chrome-extension-mv3                                                |
| [**thepulimaangani**](https://github.com/p10ns11y/thepulimaangani) | Tamil prosody, WASM parser, metre prediction | higher-order-decision-architect |
| [**arch-machine**](https://github.com/p10ns11y/arch-machine) | Arch bootstrap, archy Eagle/TEA, evidence, groxy/keeper | master-planner (`arch-guardian`), eagle (in-repo), fusion, stellar, verification |
| [**agent-prompt-tuning-lab**](https://github.com/p10ns11y/agent-prompt-tuning-lab) | Local Cursor transcript harvest → normalize → split → distill rules/skills | cursor-transcript-harvest, author-workflow-skill |


Copy overlays from [examples/overlays/](examples/overlays/) when adapting skills to a similar stack.

---

## Using skills in your project

1. **Symlink** the skills you need (global or `.cursor/skills/`).
2. **Declare** active skills in `AGENTS.md` with verification commands (`pnpm type-check`, `pnpm lint`, etc.).
3. **Optional:** Add a Cursor rule (`.cursor/rules/*.mdc`) to always apply context skills on large repos.
4. **Optional:** Copy a project overlay from [examples/](examples/README.md) into `.agents/skills/<skill>/references/`.

### Skill anatomy

```
my-skill/
├── SKILL.md          # Required — frontmatter + instructions
├── reference.md      # Optional deep docs
├── scripts/          # Optional utilities agents can run
└── templates/        # Optional briefs, configs
```

Descriptions must be **third-person**, **specific**, and include **trigger terms** — agents route on `description`, not the title.

Author new skills with [author-workflow-skill](author-workflow-skill/SKILL.md).

### Optional Cursor rules (`rules/`)

Some skills ship a thin **`.mdc` router** in [`rules/`](rules/) for `alwaysApply: true` behavior — e.g. [higher-order-decision-architect.mdc](rules/higher-order-decision-architect.mdc) loads the full skill on material decisions without duplicating the framework in every project. Symlink into `.cursor/rules/` alongside skills.

---

## Contributing

If you've lost a battle worth documenting, contribute the win:

1. Keep `SKILL.md` under ~500 lines; put depth in `reference.md` or `examples/`.
2. **No project-specific paths in skill bodies** — use [examples/](examples/README.md) for overlays and provenance.
3. Prefer linking between skills over duplicating guardrails.
4. Include concrete verification steps and anti-patterns — especially the ones that cost you a day.

---

## License

[MIT](LICENSE) — use, copy, modify, and ship these skills however you want. Keep the copyright notice if you redistribute the files.

If a skill saves you a battle, a post on [X (@peramanathan)](https://x.com/peramanathan) helps others find it. No obligation — just good karma if you're inclined.

**You don't need to lose the same battles we did.**

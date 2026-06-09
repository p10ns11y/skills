# Project overlays & provenance

These overlays are the **field manuals** — repo-specific tuning extracted after the generic skill won the war but still needed local coordinates.

Skills in this repo are **portable by default**. Project-specific paths live here, not in `SKILL.md` bodies, so you can copy skills into any repo without editing out someone else's battle scars.

## How overlays work

1. **Install** skills (see root [README.md](../README.md)).
2. **Optional:** Copy or symlink an overlay from `examples/overlays/` into your project:
   - `.agents/skills/<skill>/references/<your-repo>-overlay.md`, or
   - `.cursor/rules/` / `AGENTS.md` pointing agents at the overlay when working in that repo.
3. **Optional:** Copy a devcontainer example from `examples/devcontainers/` into `.devcontainer/` and pin digests per [devcontainer-hardened](../devcontainer-hardened/SKILL.md).

Overlays extend generic skills with relevance scoring, fusion targets, token paths, and verification commands for a **specific stack** — without forking the skill.

---

## Forged in real projects (after many battles)

| Project | Stack | Skills exercised | Overlay / example |
|---------|-------|------------------|-------------------|
| **devprofile** | Next.js 16 App Router, Biome, Tailwind v4, Playwright + host browser E2E, CV/PDF, X search | `ai-optimization`, `fusion-sage`, `semantic-markup-css`, `devcontainer-hardened`, `project-editor-profile`, `upgrade-packages`, `fix-dependency-security`, `audit-allow-builds` | [overlays/nextjs-portfolio-typescript.md](overlays/nextjs-portfolio-typescript.md), [overlays/nextjs-portfolio-fusion-playbook.md](overlays/nextjs-portfolio-fusion-playbook.md), [overlays/nextjs-portfolio-marketing-css.md](overlays/nextjs-portfolio-marketing-css.md), [devcontainers/nextjs-portfolio.*](devcontainers/) |
| **collab-finder** | Tauri 2, Rust reactor, React/TS, X API + xAI, MCP, SQLite, CV promote guard | `finder-reactor`, `agentic-reactor`, `tauri-agentic`, `tauri-ipc-debug`, `x-agent-resources`, `cv-promote-guard`, `gt-flow`, `git-worktrees`, `concurrent-cli-agents` | App docs under `docs/` in that repo; patterns are generic in skills |
| **premflow** | C, CMake, elomaxz MVU | `mvu-refactor-plan`, `explore-repo-readonly`, `subagent-explore-report`, `src-tree-reorganize` | Use skills as-is; attach your implementation plan |

---

## Overlay catalog

### Next.js portfolio (devprofile-derived)

| File | Pairs with | Purpose |
|------|------------|---------|
| [nextjs-portfolio-typescript.md](overlays/nextjs-portfolio-typescript.md) | [ai-optimization](../ai-optimization/SKILL.md) | Relevance scoring, compression rules, E2E/host-browser patterns |
| [nextjs-portfolio-fusion-playbook.md](overlays/nextjs-portfolio-fusion-playbook.md) | [fusion-sage](../fusion-sage/SKILL.md) | Domain fusion targets, surplus ideas, `fusion-state.json` seeds |
| [nextjs-portfolio-marketing-css.md](overlays/nextjs-portfolio-marketing-css.md) | [semantic-markup-css](../semantic-markup-css/SKILL.md) | Token files, landmarks, native `<dialog>` / form patterns |

### Devcontainers

| File | Pairs with |
|------|------------|
| [nextjs-portfolio.devcontainer.json](devcontainers/nextjs-portfolio.devcontainer.json) | [devcontainer-hardened](../devcontainer-hardened/SKILL.md) |
| [nextjs-portfolio.Dockerfile](devcontainers/nextjs-portfolio.Dockerfile) | [devcontainer-hardened](../devcontainer-hardened/SKILL.md) |

Before use: resolve Node LTS major, pin image digest, align `packageManager` with `package.json`.

---

## devprofile — quick reference (for overlay authors)

These notes were removed from skill bodies; keep them here when maintaining devprofile overlays.

**Lint/format:** Biome only (`pnpm lint`, `pnpm format`) — no ESLint.

**E2E:** Playwright drives a **host-installed browser** (Brave Beta via `executablePath`), not `playwright install chromium`. Read full `playwright.config.ts`, browser helper, and `tests/e2e/` when touching E2E.

**pnpm policy:** `minimumReleaseAge: 1440`, `trustPolicy: no-downgrade`, `strictDepBuilds`, explicit `allowBuilds` whitelist (`sharp`, `onnxruntime-node`, `protobufjs`, `unrs-resolver`, `esbuild`). Installs via `sfw pnpm install` when hardened.

**Key deps:** Next 16 (exact pin), React 19, TypeScript 6, Tailwind 4, `@huggingface/transformers`, `@playwright/test`.

---

## collab-finder — quick reference

**Reactor stack:** Rust `FinderReactor` + Tauri invoke + optional MCP server; React dashboard with command palette.

**External CV repo:** Configured path (e.g. portfolio checkout) — all writes via [cv-promote-guard](../cv-promote-guard/SKILL.md).

**X resources:** Vendored `.agents/x-resources/skill.md` + live docs; refresh script when upstream changes.

**IPC debug:** Project maintains `docs/tauri-ipc-debugging.md` — [tauri-ipc-debug](../tauri-ipc-debug/SKILL.md) describes the triage layers generically.

---

## premflow — quick reference

**MVU library:** [elomaxz](https://github.com/elomaxz/elomaxz) patterns via CMake `FetchContent`.

**Workflow:** Readonly explore ([explore-repo-readonly](../explore-repo-readonly/SKILL.md)) → plan ([mvu-refactor-plan](../mvu-refactor-plan/SKILL.md)) → small CMake/build steps.

---

## Creating your own overlay

Minimal template:

```markdown
# my-app — ai-optimization overlay

**Provenance:** my-app (Next.js 15, ESLint, Vitest)

Load with [typescript-optimizer.md](../../ai-optimization/references/typescript-optimizer.md).

## Project snapshot
[4 lines: stack, verify commands, test runner]

## Relevance scoring
| Signal | Boost | Notes |
| ...

## Never compress
- ...
```

Add a row to the **Battle-tested on** table above when you contribute an overlay back to this repo.

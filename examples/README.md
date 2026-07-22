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
| [**devprofile**](https://github.com/p10ns11y/devprofile) | Next.js 16, Biome, Tailwind v4, host-browser E2E, CV/PDF, X post search picker, xAI API, xAI collections (embedded datasets) | `ai-optimization`, `fusion-sage`, `semantic-markup-css`, `devcontainer-hardened`, `project-editor-profile`, `upgrade-packages`, `fix-dependency-security`, `audit-allow-builds` | [overlays/nextjs-portfolio-typescript.md](overlays/nextjs-portfolio-typescript.md), [overlays/nextjs-portfolio-fusion-playbook.md](overlays/nextjs-portfolio-fusion-playbook.md), [overlays/nextjs-portfolio-marketing-css.md](overlays/nextjs-portfolio-marketing-css.md), [devcontainers/nextjs-portfolio.*](devcontainers/) |
| [**collab-finder**](https://github.com/p10ns11y/collab-finder) | Tauri 2, Rust reactor, React/TS, X API + xAI, MCP, SQLite, CV promote guard | `finder-reactor`, `agentic-reactor`, `tauri-agentic`, `tauri-ipc-debug`, `x-agent-resources`, `cv-promote-guard`, `gt-flow`, `git-worktrees`, `concurrent-cli-agents` | App docs under `docs/` in that repo; patterns are generic in skills |
| [**premflow**](https://github.com/thecuriousts/premflow) | C, CMake, elomaxz MVU | `mvu-refactor-plan`, `explore-repo-readonly`, `subagent-explore-report`, `src-tree-reorganize` | Use skills as-is; attach your implementation plan |
| [**sorkalam-extension**](https://github.com/p10ns11y/sorkalam-extension) | MV3 Chrome extension, vanilla JS, Tamil ↔ English dictionary | `chrome-extension-mv3` | [overlays/sorkalam-mv3-extension.md](overlays/sorkalam-mv3-extension.md) |
| [**agent-prompt-tuning-lab**](https://github.com/p10ns11y/agent-prompt-tuning-lab) | Cursor transcript harvest, normalize, split, artifact distillation | `cursor-transcript-harvest`, `author-workflow-skill` | Run pipeline in that repo; see its [docs/PIPELINE.md](https://github.com/p10ns11y/agent-prompt-tuning-lab/blob/master/docs/PIPELINE.md) |
| [**thepulimaangani**](https://github.com/p10ns11y/thepulimaangani) | Tamil prosody, WASM parser, metre prediction | `higher-order-decision-architect` | [overlays/thepulimaangani-decision-hooks.md](overlays/thepulimaangani-decision-hooks.md) |
| [**shellyxz/shell**](https://github.com/p10ns11y/shell) | Portable PATH kernel, `av`/`ab` verify bridge, PLUGIN boundary, ontology graph | `verification-cockpit`, `shell-kernel-ontology`, `stellar-roadmap`, `ai-optimization`, `fusion-sage` | [overlays/shell-av-workflow.md](overlays/shell-av-workflow.md), [overlays/shellyxz-shell-kernel.md](overlays/shellyxz-shell-kernel.md) |
| [**arch-machine**](https://github.com/p10ns11y/arch-machine) | Arch bootstrap + archy Eagle/TEA + evidence loop + groxy/keeper | `master-planner` pack `arch-guardian`, eagle (in-repo), fusion, HODA, stellar, verification | [overlays/arch-machine-master-planner.md](overlays/arch-machine-master-planner.md); live `.agents/ontology/` in that repo |

---

## Overlay catalog

### Next.js portfolio ([devprofile](https://github.com/p10ns11y/devprofile)-derived)

| File | Pairs with | Purpose |
|------|------------|---------|
| [nextjs-portfolio-typescript.md](overlays/nextjs-portfolio-typescript.md) | [ai-optimization](../ai-optimization/SKILL.md) | Relevance scoring, compression rules, E2E/host-browser patterns |
| [nextjs-portfolio-fusion-playbook.md](overlays/nextjs-portfolio-fusion-playbook.md) | [fusion-sage](../fusion-sage/SKILL.md) | Domain fusion targets, surplus ideas, `fusion-state.json` seeds |
| [nextjs-portfolio-marketing-css.md](overlays/nextjs-portfolio-marketing-css.md) | [semantic-markup-css](../semantic-markup-css/SKILL.md) | Token files, landmarks, native `<dialog>` / form patterns |

### Chrome MV3 extension ([sorkalam-extension](https://github.com/p10ns11y/sorkalam-extension)-derived)

| File | Pairs with | Purpose |
|------|------------|---------|
| [sorkalam-mv3-extension.md](overlays/sorkalam-mv3-extension.md) | [chrome-extension-mv3](../chrome-extension-mv3/SKILL.md) | File map, message actions, Tamil VU fetch rules |

### Decision architect ([thepulimaangani](https://github.com/p10ns11y/thepulimaangani)-derived)

| File | Pairs with | Purpose |
|------|------------|---------|
| [thepulimaangani-decision-hooks.md](overlays/thepulimaangani-decision-hooks.md) | [higher-order-decision-architect](../higher-order-decision-architect/SKILL.md) | WASM/metre contract hooks, branch sync |

### Shell kernel ([shellyxz/shell](https://github.com/p10ns11y/shell)-derived)

| File | Pairs with | Purpose |
|------|------------|---------|
| [shell-av-workflow.md](overlays/shell-av-workflow.md) | [verification-cockpit](../verification-cockpit/SKILL.md) | `av`/`ab` runtime, verify-launch.sh, per-project delegation |
| [shellyxz-shell-kernel.md](overlays/shellyxz-shell-kernel.md) | [stellar-roadmap](../stellar-roadmap/SKILL.md) | Live scorecard + SN priorities for shell config dogfood |

### Devcontainers

| File | Pairs with |
|------|------------|
| [nextjs-portfolio.devcontainer.json](devcontainers/nextjs-portfolio.devcontainer.json) | [devcontainer-hardened](../devcontainer-hardened/SKILL.md) |
| [nextjs-portfolio.Dockerfile](devcontainers/nextjs-portfolio.Dockerfile) | [devcontainer-hardened](../devcontainer-hardened/SKILL.md) |

Before use: resolve Node LTS major, pin image digest, align `packageManager` with `package.json`.

---

## [devprofile](https://github.com/p10ns11y/devprofile) — quick reference (for overlay authors)

These notes were removed from skill bodies; keep them here when maintaining devprofile overlays.

**Lint/format:** Biome only (`pnpm lint`, `pnpm format`) — no ESLint.

**E2E:** Playwright drives a **host-installed browser** (Brave Beta via `executablePath`), not `playwright install chromium`. Read full `playwright.config.ts`, browser helper, and `tests/e2e/` when touching E2E.

**Domains:** CV/PDF generation and viewing; **X post search picker**; **xAI API** for Profile Q&A and related flows; **xAI collections** shipped as built-in embedded datasets (not live-fetched at runtime for core grounding).

**pnpm policy:** `minimumReleaseAge: 1440`, `trustPolicy: no-downgrade`, `strictDepBuilds`, explicit `allowBuilds` whitelist (`sharp`, `onnxruntime-node`, `protobufjs`, `unrs-resolver`, `esbuild`). Installs via `sfw pnpm install` when hardened.

**Key deps:** Next 16 (exact pin), React 19, TypeScript 6, Tailwind 4, `@huggingface/transformers`, `@playwright/test`, xAI client SDK.

---

## [collab-finder](https://github.com/p10ns11y/collab-finder) — quick reference

**Reactor stack:** Rust `FinderReactor` + Tauri invoke + optional MCP server; React dashboard with command palette.

**External CV repo:** Configured path (e.g. portfolio checkout) — all writes via [cv-promote-guard](../cv-promote-guard/SKILL.md).

**X resources:** Vendored `.agents/x-resources/skill.md` + live docs; refresh script when upstream changes.

**IPC debug:** Project maintains `docs/tauri-ipc-debugging.md` — [tauri-ipc-debug](../tauri-ipc-debug/SKILL.md) describes the triage layers generically.

---

## [premflow](https://github.com/thecuriousts/premflow) — quick reference

**MVU library:** [elomaxz](https://github.com/elomaxz/elomaxz) patterns via CMake `FetchContent`.

**Workflow:** Readonly explore ([explore-repo-readonly](../explore-repo-readonly/SKILL.md)) → plan ([mvu-refactor-plan](../mvu-refactor-plan/SKILL.md)) → small CMake/build steps.

---

## [sorkalam-extension](https://github.com/p10ns11y/sorkalam-extension) — quick reference

**Stack:** MV3, vanilla JS — popup + `event.js` service worker + `content.js` on `<all_urls>`.

**Fetch rule:** Tamil VU (`tamilvu.org`) only from service worker with `host_permissions`; popup uses `sendMessage`.

**Message actions:** `getSelectedWordFromPage`, `getSelectedWord`, `fetchTamilVUGlossary` — keep names in sync across layers.

**Docs:** `TECH_DETAILS_V6.md` in the sorkalam repo for full architecture.

---

## agent-prompt-tuning-lab — quick reference

**Repo:** [github.com/p10ns11y/agent-prompt-tuning-lab](https://github.com/p10ns11y/agent-prompt-tuning-lab) — privacy-first local pipeline to harvest Cursor agent transcripts and distill rules, skills, and gold exemplars.

**Quick start:** `pnpm harvest:all && pnpm seed-manifest && pnpm normalize && pnpm split` (run in that repo on the host with `~/.cursor/projects`).

**Skills here:** [cursor-transcript-harvest](../cursor-transcript-harvest/SKILL.md) (harvest commands), [author-workflow-skill](../author-workflow-skill/SKILL.md) (SKILL.md authoring).

**Do not commit:** raw transcripts, processed turns, or `data/manifest.jsonl` from the lab.

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

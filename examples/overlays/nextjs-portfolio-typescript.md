# Next.js portfolio — TypeScript / JavaScript overlay

**Example provenance:** [devprofile](https://github.com/p10ns11y/devprofile) — Next.js 16 App Router portfolio.  
**Generic rules:** [typescript-optimizer.md](../../ai-optimization/references/typescript-optimizer.md).

Copy into your project as `.agents/skills/ai-optimization/references/<repo>-typescript.md` and reference from `AGENTS.md` or a Cursor rule.

## Project snapshot (~4 lines, always include)

Next.js 16 App Router **single app** under `src/`. `@/*` → `./src/*`. **Client components for interactive UI** — no async RSC for UI state ([react-client-expert](../../react-client-expert/SKILL.md)). Domains: CV/PDF, X post search picker, xAI API (Profile Q&A), xAI collections as embedded datasets. E2E: host-browser Playwright at repo root. Verify: `pnpm type-check`, `pnpm lint` (Biome).

## Relevance scoring

| Signal | Boost | Notes |
|---|---|---|
| Host-browser Playwright config, `tests/e2e/**` | +30 | E2E — read full |
| `src/app/api/**` | +25 | Route handlers + types |
| `src/components/**`, `src/hooks/**` | +20 | Client UI |
| `src/lib/**`, `src/utils/**`, `src/types/**` | +20 | Shared logic / contracts |
| `src/data/**`, `src/config/**` | +15 | Static config / content |
| `scripts/**` | +10 unless query mentions script/PDF/E2E |
| `public/**`, `*.css`, generated PDF assets | −40 | Skip unless asset-specific task |
| `next-env.d.ts`, `.next/**` | −60 | Never include |

## Never compress — read full

- **E2E:** browser helper, `playwright.config.ts`, `tests/e2e/global-setup.ts`, spec under edit, `tests/e2e/helpers/**`
- **Types:** `src/types/**`, exported props interfaces, Playwright `PlaywrightTestConfig` derivations
- **API contracts:** request/response shapes in `src/app/api/**/route.ts` when touching domain APIs
- **Env toggles:** feature flags in `.env` — read actual names from repo
- **Project rules:** `.cursor/rules/*` when globs match the task

## Compress aggressively

- **Marketing sections:** hero, about, site/*, marketing.css — props + one-line render summary
- **UI primitives:** `src/components/ui/*` — export signature only unless editing that component
- **Document viewers:** summarize as "PDF via react-pdf / document-viewer; native `<dialog>` where used"

## Module cheat sheet (example layout)

```
src/app/           App Router pages + layouts
src/app/api/       Route handlers
src/components/    Client + presentational
src/hooks/         Shared hooks
src/lib/           Domain helpers
src/utils/         Cross-cutting utilities
src/data/          Static content
tests/e2e/         Playwright specs
playwright.*.ts    Repo root — not under tests/
scripts/           Build / PDF / editor sync
```

## React / Next.js

- **`"use client"`** where interaction/state — summarize as "client: useState/useEffect|Query for X"
- **Do not** assume Server Components for modals, forms, theme toggle, or chat UIs
- **Data:** prefer TanStack Query / `use()` + Suspense over effect+fetch
- **Imports:** preserve path alias (`@/…`) in summaries

## Playwright types (host browser pattern)

```ts
type HostBrowserLaunchOptions = NonNullable<
  NonNullable<PlaywrightTestConfig["use"]>["launchOptions"]
>;
// Prefer config-aligned types over importing LaunchOptions from @playwright/test
```

## Verify (mandatory after multi-file TS/TSX)

```bash
pnpm type-check
pnpm lint
```

E2E changes: read project's E2E README — prefer host browser over `playwright install chromium` when configured.

**Fusion handoff:** architecture or 3+ related queries → [nextjs-portfolio-fusion-playbook.md](nextjs-portfolio-fusion-playbook.md) + [fusion-sage](../../fusion-sage/SKILL.md).

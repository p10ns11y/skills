# Next.js portfolio — Fusion Playbook

**Example provenance:** [devprofile](https://github.com/p10ns11y/devprofile) (Next.js 16 portfolio).  
Load with [fusion-playbooks.md](../../fusion-sage/fusion-playbooks.md) and fission overlay [nextjs-portfolio-typescript.md](nextjs-portfolio-typescript.md).

## Project snapshot (fusion context)

Next.js 16 portfolio: **client UI for interactivity** (no async RSC for state). Example domains: **CV/PDF**, **Profile Q&A**, **content hub**, **X search**, **certificates**, **E2E (host browser)**. Agent tooling: **ai-optimization** (fission) + **fusion-sage** (this playbook).

## High-stability fusion targets (iron-peak candidates)

| Domain | Source files (≥2 required) | Fused abstraction |
|---|---|---|
| **CV Q&A** | generator + API route + UI component | `CvQaReactor` — retrieve → route → generate |
| **Document viewing** | viewer components + API routes | `DocumentViewReactor` — PDF + sidebar + download |
| **X search** | lib + components + page | `XSearchReactor` — dates, sections, filter links |
| **E2E host browser** | playwright config + global setup + helper | `HostBrowserE2eReactor` — IDE-safe launch options |
| **Agent skills** | ai-optimization + fusion-sage | `ConnectedReactor` — fission route + fusion surplus |

## Fusion rules (override generic TS playbook)

1. **No Server-Component UI fusion** — fuse interactive features as **client feature reactors** ([react-client-expert](../../react-client-expert/SKILL.md)).
2. **E2E surplus must preserve host browser** — never fuse toward bundled Chromium if the repo uses `executablePath`.
3. **Low-priority marketing** — hero/about sections: summarize unless refactor touches shared layout/types.

## Example fusion output

```markdown
## Fused Abstraction: HostBrowserE2eReactor
playwright helper + config + global-setup
→ launchOptions returns path only (IDE-safe); assert browser at test run.
Binding energy: High (every E2E spec depends on this)

⚡ Fusion Surplus (Q ≈ 1.4)
Persist in fusion-state.json so agents stop re-discovering Playwright type mismatches.
```

## Surplus ideas

| Trigger | Surplus suggestion |
|---|---|
| Third CV/Q&A change | Extract `useCvQa()` hook wrapping cache + API |
| Multiple X search UI edits | Single `useXSearchWindow()` for dates + URL sync |
| Repeated E2E + config questions | Seed `fusion-state.json` with E2E reactor node |

## Knowledge graph path

Persist: `.agents/skills/fusion-sage/fusion-state.json` (schema: `fusion-state.schema.json`).

## Verify after fusion-impacting changes

```bash
pnpm type-check
pnpm lint
# E2E when UI/routing changed
```

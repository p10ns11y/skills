# Next.js portfolio — semantic markup & CSS overlay

**Example provenance:** devprofile marketing UI.  
Load with [semantic-markup-css](../../semantic-markup-css/SKILL.md) when editing this repo's landing/marketing pages.

## Token files (example layout)

| File | Role |
|------|------|
| `src/styles/brand/theme.css` | oklch brand, surfaces, text — **fix contrast here first** |
| `src/styles/marketing.css` | `@layer components`: `[data-section]`, `[data-state]`, reduced motion |
| `src/styles/globals.css` | Imports Tailwind + theme + marketing |

Map component-library vars (`--primary`, `--muted-foreground`) to brand tokens so buttons/inputs inherit contrast-safe colors.

## Site primitives

Example under `src/components/site/`:

- `SectionShell` — `<section data-section={id} aria-labelledby={headingId}>`
- `SectionHeading` — single `h2` + optional eyebrow
- `PageShell` — header/footer wrapper; one `<main>` at layout level only
- `SiteButton` — shadcn `Button` + `asChild` for native `<a>`

## Native patterns

| Feature | Target pattern |
|---------|----------------|
| Mobile nav | `<button aria-expanded aria-controls="…">` + `data-state` |
| Modal viewer | `<dialog>` + URL/search-param hook; style `[open]` in CSS — not unconditional `display:flex` on `<dialog>` |
| Contact form | `<form data-status={…}>` + `role="status" aria-live="polite"` |
| Lists | `<ul>` / `<li>` / `<article data-card="…">` |

## Verify

```bash
pnpm type-check
pnpm lint
```

Manual: keyboard nav; Esc closes dialog; contrast on surfaces in light + dark themes.

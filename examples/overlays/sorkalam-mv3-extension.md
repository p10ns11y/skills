# Sorkalam — MV3 extension overlay

**Example provenance:** [sorkalam-extension](https://github.com/p10ns11y/sorkalam-extension) — Tamil ↔ English MV3 Chrome extension (Wiktionary + Tamil VU glossary). Vanilla JS, no frameworks.

Copy into the Sorkalam repo as `.agents/skills/chrome-extension-mv3/references/sorkalam-overlay.md` and point `AGENTS.md` at it when working in that project.

## Project snapshot

MV3 extension: popup UI + service worker + content script on `<all_urls>`. Dictionary lookup via Wiktionary API and Tamil VU glossary (HTML table parsed in popup). IndexedDB cache shared between popup and service worker.

Full architecture: `TECH_DETAILS_V6.md` at repo root (read when changing cross-layer behavior).

## File map

| File | Role |
|------|------|
| `popup.js` | UI, Wiktionary fetch, Tamil VU via `sendMessage`, `normalizeInput()` |
| `glossary-cache.js` | IndexedDB cache for Tamil VU HTML + parsed entries (popup + SW) |
| `tamilvu-glossary-parse.js` | HTML table → `{ columns, rows }` JSON via `DOMParser` (popup only) |
| `event.js` | Service worker: selection relay, Tamil VU fetch + IDB HTML cache |
| `content.js` | `lastCapturedSelection`, answers `getSelectedWord` |
| `manifest.json` | MV3 permissions, `<all_urls>` content script |

## Message actions (keep names consistent)

| Action | Sender → receiver | Response |
|--------|-------------------|----------|
| `getSelectedWordFromPage` | popup → `event.js` | `{ selectedWord }` |
| `getSelectedWord` | `event.js` → content script | `{ selectedWord }` |
| `fetchTamilVUGlossary` | popup → `event.js` | `{ ok, glossaryPageHtml, fromCache?, cacheKey }` or error |

**Cache flow:** Popup checks `GlossaryCache.getTamilVu` for `glossaryEntries` first; else parse HTML and `setTamilVu` with table + entries. Each entry: `{ translationText, subjectArea }` (opposite language from search). Service worker caches HTML on network fetch.

## Project-specific rules

1. **Tamil VU:** never `fetch` tamilvu.org from the popup — use `event.js` + `host_permissions` (HTTPS only).
2. **English input:** lowercase via `normalizeInput()` before Tamil VU / Wiktionary.
3. **Selection:** cache in content script; popup opens often clear live `getSelection()`.
4. **Icons:** only reference PNGs that exist, or omit from manifest.

## Verify

Load unpacked extension in Chrome → test selection on a page → popup lookup (English and Tamil). Check service worker console for Tamil VU fetch / cache logs.

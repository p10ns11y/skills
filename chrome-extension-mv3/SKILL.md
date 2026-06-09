---
name: chrome-extension-mv3
description: >-
  Manifest V3 Chrome extension development — service worker lifecycle, message passing
  (popup ↔ service worker ↔ content script), content script injection, and host_permissions
  fetch patterns. Use when editing manifest.json, background/service worker, popup, content
  scripts, chrome.runtime.sendMessage, or extension permissions.
---

# Chrome extension (Manifest V3)

Vanilla MV3 patterns for extensions without a bundler/framework in the active path. Pair with project overlays for app-specific file maps and message action names ([examples/overlays/](../examples/overlays/)).

## Architecture (typical three-layer)

| Layer | Runs in | Typical files | Responsibilities |
|-------|---------|---------------|------------------|
| **Popup / UI** | Extension page | `popup.html`, `popup.js` | User input, display, orchestrates messages to SW |
| **Service worker** | Background (ephemeral) | `background.js`, `event.js`, `sw.js` | Network fetch needing `host_permissions`, relay, durable cache |
| **Content script** | Isolated world on web pages | `content.js` | DOM/selection access, page context, no extension APIs for cross-origin fetch |

Read the project's overlay or `TECH_DETAILS*.md` / `AGENTS.md` for exact filenames.

## Rules for changes

1. **Async `sendResponse`**: async work in message handlers → IIFE + `return true`, or return a Promise (Chrome 99+ only). See [references/message-passing.md](references/message-passing.md).
2. **Cross-origin fetch**: pages and popups cannot bypass host restrictions — fetch from the **service worker** when `host_permissions` are declared; never duplicate fetch in popup if SW already owns that origin.
3. **Service worker state**: no globals — use `chrome.storage` / IndexedDB; listeners registered at top level. See [references/service-worker.md](references/service-worker.md).
4. **Selection**: cache selection in the content script; popup open often clears live `window.getSelection()`.
5. **Manifest assets**: only reference icons/paths that exist; MV3 requires `service_worker` not `background.scripts`.
6. **Content scripts**: isolated world — use messaging for SW coordination. See [references/content-scripts.md](references/content-scripts.md).

## Message passing checklist

```
- [ ] Action/type names match across popup, SW, and content script
- [ ] Async handlers: return true (IIFE) or return Promise — not both
- [ ] tabs.sendMessage: handle "receiving end does not exist" (script not injected yet)
- [ ] Only one listener should sendResponse per message type
```

## MV3 references (this skill)

- [message-passing.md](references/message-passing.md) — popup ↔ service worker ↔ content script
- [service-worker.md](references/service-worker.md) — lifecycle, storage, alarms
- [content-scripts.md](references/content-scripts.md) — injection, DOM, messaging

## Upstream (do not vendor)

- [GoogleChrome/modern-web-guidance — chrome-extensions](https://github.com/GoogleChrome/modern-web-guidance/tree/main/skills/chrome-extensions)
- Search guides: `npx -y modern-web-guidance@latest search "…"` — do not copy the full guide tree into your repo.

## Project overlay

If the repo ships a file map, message action table, or domain-specific fetch rules, load it from `.agents/skills/chrome-extension-mv3/references/` or [examples/overlays/sorkalam-mv3-extension.md](../examples/overlays/sorkalam-mv3-extension.md) (Sorkalam dictionary extension).

**Example provenance:** [sorkalam-extension](https://github.com/p10ns11y/sorkalam-extension).

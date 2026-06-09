---
name: tauri-ipc-debug
description: Systematic Tauri IPC debugging — triage Intent Engine layers (MVU → safeInvoke → Rust commands → HTTP/sqlite/keyring), avoid false leads (browser Network tab, keyring noise). Use when invoke fails, search/cycle broken, bearer errors, tauri dev hangs, blank window, or user asks to debug Tauri/desktop shell issues.
---

# Tauri IPC Debug

**Mission:** Fix desktop shell issues fast by tracing **one layer at a time**. Do not patch random files until the failing layer is identified.

**Canonical doc:** Your project should maintain `docs/tauri-ipc-debugging.md` (and related command maps). Read those first if present.

Pair with [tauri-agentic](tauri-agentic/SKILL.md) for architecture; [finder-reactor](../finder-reactor/SKILL.md) for guard/cycle logic; [x-agent-resources](../x-agent-resources/SKILL.md) for platform API errors after IPC proves Rust ran.

---

## Rules (non-negotiable)

1. **`invoke` is not HTTP** — Browser Network tab will not show Tauri commands. External API calls appear in the **terminal** running `tauri dev`.
2. **Single IPC seam** — Prefer one adapter module (e.g. `safe-invoke.ts`) that wraps `@tauri-apps/api`. Debug there before scattering `invoke`.
3. **Secrets in Rust** — Bearer/tokens read in commands from keyring/file store, not passed from UI each call.
4. **Keyring fallback ≠ IPC failure** — keyring read failure with file fallback is often expected on Linux without Secret Service.
5. **Verify with evidence** — Quote ipc logs, db logs, or handler `eprintln!` before claiming root cause.

---

## Triage checklist

```text
IPC debug progress:
- [ ] Repro captured (user action + expected vs actual)
- [ ] Layer identified (intent | ipc-js | ipc-rust | http | sqlite | webview)
- [ ] Dev running: pnpm tauri dev (terminal visible)
- [ ] Console: ipc adapter logs
- [ ] Terminal: secrets / db / platform client logs after repro
- [ ] Fix applied at correct layer only
- [ ] Repro retried; build + cargo check if code changed
```

---

## Step 0 — Classify symptom

| Symptom | Start at |
|---------|----------|
| Blank window / crash on launch | WebKit/GTK deps — not IPC |
| UI frozen, no error banner | Rust blocked / hang |
| Error banner in app | ipc-js then ipc-rust |
| "Bearer not configured" | secrets storage |
| Platform API 400/401/403 | HTTP layer after invoke proves Rust ran |
| History/DB empty | sqlite layer |

---

## Layer map (generic)

```
UI intent → safeInvoke (JS) → Tauri command (Rust) → { sqlite | keyring | HTTP client }
```

Debug top-down: confirm intent fired → ipc request/response → Rust handler entry → downstream service.

---

## Common fixes by layer

**ipc-js**: Wrong command name, unhandled promise, adapter swallowing errors — enable dev logging in the single seam module.

**ipc-rust**: Panic in handler, blocking sync call on async runtime, wrong serde types — add `eprintln!` at handler entry with args summary.

**secrets**: Missing token file, wrong app identifier, keyring unavailable — check config path and fallback file permissions (`0600`).

**sqlite**: Migration not run, WAL lock, wrong app data dir — verify DB path under XDG/app data.

**HTTP client**: Malformed query (see x-agent-resources), expired token, rate limit — read terminal output from Rust client, not browser.

**webview**: Missing `webkit2gtk`/GTK on Linux — install platform deps per Tauri docs.

---

## Anti-patterns

- Adding `invoke` calls outside the adapter seam without updating the decision table
- Fixing UI state when Rust never received the command
- Assuming Network tab shows Tauri or X API traffic
- Patching bearer in frontend instead of secrets module

**Example provenance:** [collab-finder](../examples/README.md) — see [decision-table.md](decision-table.md) for a sample layer map.

# Tauri IPC — decision table (example)

Use with [SKILL.md](./SKILL.md). Your app should maintain a fuller table in `docs/tauri-ipc-debugging.md`.

| Signal | Layer | Typical fix |
|--------|-------|-------------|
| `[ipc ←] err` + bearer message | Secrets | Check app data token file / keyring entry |
| `[secrets] … present=false` | Secrets | Re-save token via settings UI; verify file permissions (`0600`) |
| No ipc logs at all | ipc-js | Enable adapter dev logging; verify command name |
| Rust panic in terminal | ipc-rust | Fix handler; check serde types |
| 401 after invoke succeeds | HTTP client | Token expired or wrong scopes — see [x-agent-resources](../x-agent-resources/SKILL.md) |

**Example provenance:** collab-finder layer map — adapt paths to your app's data dir and command names.

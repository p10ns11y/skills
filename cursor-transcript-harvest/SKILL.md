---
name: cursor-transcript-harvest
description: >-
  Harvest Cursor agent transcripts into agent-prompt-tuning-lab: pnpm harvest:all,
  seed-manifest, env vars, subagents, and gold tagging. Use when collecting or
  re-indexing local Cursor JSONL for this repo.
---

# Cursor transcript harvest

Run on the **host** where `~/.cursor/projects` exists (not inside a devcontainer-only shell unless harvesting devcontainer paths).

## Full harvest

```bash
cd /path/to/agent-prompt-tuning-lab   # repo root
pnpm harvest:all
pnpm seed-manifest
pnpm normalize
```

`harvest:all` = host `--all --unpack` + devcontainer unpack. Subagent files land at:

`data/raw/<source>/<YYYYMMDD>/<workspace-slug>/<parent-session-id>/subagents/<subagent-id>.jsonl`

## Selective harvest

```bash
pnpm harvest:host -- --all --unpack
CURSOR_REPO_NAMES=my-app,other-repo pnpm harvest:host -- --unpack
pnpm harvest:devcontainer -- --unpack
```

| Variable | Purpose |
|----------|---------|
| `CURSOR_PROJECTS_HOST` | Override `~/.cursor/projects` |
| `CURSOR_REPO_NAMES` | Comma-separated slug fragments |
| `CURSOR_TRANSCRIPTS_DEVCONTAINER` | Override devcontainer transcripts path |

## After harvest

1. `pnpm seed-manifest` — append manifest rows (`parent_session_id` for subagents).
2. `pnpm normalize` — default `--source host` to avoid duplicate sessions from devcontainer copies.
3. Optional gold tags: `pnpm tag-manifest -- --tag gold --session-id <uuid>`.

## Privacy

Do not commit `data/raw`, `data/processed`, zips, or `data/manifest.jsonl`. See `.cursor/rules/data-privacy.mdc`.

## Reference

- [docs/PIPELINE.md](../../docs/PIPELINE.md)
- [docs/GOLD_SESSIONS.md](../../docs/GOLD_SESSIONS.md)

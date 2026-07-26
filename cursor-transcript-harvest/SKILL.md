---
name: cursor-transcript-harvest
description: >-
  Harvest Cursor, Grok Build, Kilo, and Cline agent transcripts into
  agent-prompt-tuning-lab: pnpm harvest:all, seed-manifest, env vars, and gold
  tagging. Use when collecting or re-indexing local agent JSONL for this repo.
---

# Agent transcript harvest

Run on the **host** where agent data lives (`~/.cursor/projects`, `~/.grok/sessions`, VS Code/Cursor `globalStorage`), not inside a devcontainer-only shell unless harvesting those paths.

## Full harvest → distill

```bash
cd /path/to/agent-prompt-tuning-lab   # repo root
pnpm harvest:all
pnpm normalize          # --source all
pnpm split

pnpm rhai-host:build
pnpm distill-sessions -- --pilot --llm grok
pnpm distill-workflows -- --run-dir data/distill/<run-id>
# review drafts/, then:
pnpm install-distill -- --run-dir data/distill/<run-id> --profile personal-skills
```

`harvest:all` = Cursor host `--all --unpack` + devcontainer unpack + Grok/Kilo/Cline convert+unpack.

Cursor subagent files land at:

`data/raw/host/<YYYYMMDD>/<workspace-slug>/<parent-session-id>/subagents/<subagent-id>.jsonl`

Grok/Kilo/Cline land under `data/raw/{grok,kilo,cline}/…` as Cursor-shaped JSONL. See [docs/AGENT_SOURCES.md](../../docs/AGENT_SOURCES.md).

## Selective harvest

```bash
pnpm harvest:cursor
pnpm harvest:agents
pnpm harvest:grok
pnpm harvest:kilo
pnpm harvest:cline
pnpm harvest:host -- --all --unpack
CURSOR_REPO_NAMES=my-app,other-repo pnpm harvest:host -- --unpack
pnpm harvest:devcontainer -- --unpack
```

| Variable | Purpose |
|----------|---------|
| `CURSOR_PROJECTS_HOST` | Override `~/.cursor/projects` |
| `CURSOR_REPO_NAMES` | Comma-separated slug fragments |
| `CURSOR_TRANSCRIPTS_DEVCONTAINER` | Override devcontainer transcripts path |
| `GROK_SESSIONS_ROOT` | Override `~/.grok/sessions` |
| `KILO_TASKS_ROOT` | Override Kilo `tasks/` directory |
| `CLINE_TASKS_ROOT` | Override Cline/Roo `tasks/` directory |

## After harvest

1. `pnpm seed-manifest` — usually auto-run after unpack; appends manifest rows (`parent_session_id` for subagents; `agent` from sidecars).
2. `pnpm normalize` — default `--source all`. Use `pnpm normalize:host` for Cursor-only.
3. Optional gold tags: `pnpm tag-manifest -- --tag gold --session-id <uuid>`.
4. Prefer **distill** for workflow/skill/rule drafts ([docs/DISTILL.md](../../docs/DISTILL.md)).

## Privacy

Do not commit `data/raw`, `data/processed`, `data/distill`, zips, or `data/manifest.jsonl`. See `.cursor/rules/data-privacy.mdc`.

## Legacy: insights / suggest-artifacts

Secondary path (histograms + bundle drafts): `pnpm insights`, then `node scripts/suggest-artifacts.mjs --bundle personal --llm grok`, review, `--apply`, then `node scripts/install-artifacts.mjs --target <repo> --bundle personal`. Skip niche ideas — see [docs/DEFERRED_SKILLS.md](../../docs/DEFERRED_SKILLS.md).

## Reference

- [docs/PIPELINE.md](../../docs/PIPELINE.md)
- [docs/DISTILL.md](../../docs/DISTILL.md)
- [docs/AGENT_SOURCES.md](../../docs/AGENT_SOURCES.md)
- [docs/GOLD_SESSIONS.md](../../docs/GOLD_SESSIONS.md)
- [docs/DEFERRED_SKILLS.md](../../docs/DEFERRED_SKILLS.md)

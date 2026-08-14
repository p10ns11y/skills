---
name: grok-host-prep
description: >-
  One-time (re-runnable) host prep for Grok Build: check binaries, lsp.json,
  [features] lsp_tools, MCP command existence, and efficiency knobs. Use when
  setting up a machine, enabling LSP, or a Feed harness_gap is mcp / permissions
  / 8192. Triggers: grok-host-prep, /grok-host-prep, prepare machine, setup LSP,
  tweak grok host, host prep.
---

# grok-host-prep

> **Load rule:** This skill owns **host checks + safe apply**. Prompt routing stays in [control-feeder](../control-feeder/SKILL.md). Do not paste MCP env/secrets. Do not nest `grok`.

```text
Check  : default — report OK / WARN / MISS
Apply  : write missing lsp.json servers; append [features] lsp_tools if absent
Install: optional LSPs only with --install
```

## When to use

| Use | Skip |
|-----|------|
| New host, missing `lsp` tool, Feed `harness_gap` | Mid-turn code edit |
| Want rust-analyzer / clangd / tsserver wired | Changing models or permission_mode |
| MCP `command` might be missing from PATH | Dumping or editing MCP secrets |

## Steps

1. Run the script (check first):

```bash
bash ~/.grok/skills/grok-host-prep/scripts/prepare.sh --check
```

2. If the report is what you want on disk:

```bash
bash ~/.grok/skills/grok-host-prep/scripts/prepare.sh --apply
```

3. Optional LSPs (only if you want them globally):

```bash
bash ~/.grok/skills/grok-host-prep/scripts/prepare.sh --apply --install
```

4. New Grok session (or restart) so `lsp.json` + `lsp_tools` load.

5. Session flags the script will not write into your shell rc — set if you want the extra tools:

| Flag | Effect |
|------|--------|
| `GROK_LSP_TOOLS=1` | same as `[features] lsp_tools = true` |
| `GROK_WEB_FETCH=1` | enable `web_fetch` (off by default) |
| `GROK_SUBAGENTS=1` | enable `task` / subagents |
| `GROK_MEMORY=1` | expose `memory_search` / `memory_get` (config `[memory] enabled` is separate) |

## What actually makes this host faster

Owned by the **harness**, not a second graph:

| Knob | Why |
|------|-----|
| `~/.grok/lsp.json` + `lsp_tools` | `goToDefinition` / references / hover instead of fat `read_file` |
| `codebase_indexing` (default true) | code-graph context; leave on |
| `output_byte_limit` ≥ 8192 | do **not** lower (repo `AGENTS.md`) |
| `rg` + `rust-analyzer` + `clangd` on PATH | this tree is Rust + some C |
| MCP `command` exists | dead `[mcp_servers.*]` wastes startup; project `.grok/config.toml` **replaces** a name entirely |
| Official `grok` = `~/.grok/bin/grok` | leftover `~/.local/bin/grok` can steal PATH |

Do **not** treat `permission_mode = always-approve` as a prep win (EVA forbids it).

## Done when

- Script printed a full check table
- `--apply` (if requested) wrote only missing LSP servers and `lsp_tools = true`
- No secrets printed; no `grok` nested

## Do not

- Rewrite `config.toml` wholesale or print `[mcp_servers.*.env]`
- Lower `output_byte_limit`
- `--install` without the user asking for extra LSPs
- Invent a second agent OS / extra graph crate

## Related

Skills: [control-feeder](../control-feeder/SKILL.md) (Feed `harness_gap`) · [eva-emptiness](../eva-emptiness/SKILL.md) (`always-approve` is not a prep win)  
Plugin: `eva-emptiness` (auth tether). Official grok binary + `bundled/` after login — not this script.

Notes in grok-build `intelli-arch-designs/`:

| Note | Use from this skill |
|------|---------------------|
| `harness-feed-filter.md` | harness knobs (perms, 8192, `AGENTS.md`, MCP) ≠ graph |
| `harness-economy-model.md` | tools dominate $; do not lower bash below 8192 or polish skill-list |
| `harness-learning-cost-roadmap.md` | official `grok`; measure with `tool-mix-observe`; no second OS |

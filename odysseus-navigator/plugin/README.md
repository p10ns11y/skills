# odysseus-navigator (plugin)

**Faster intelli core-nailer** for [p10ns11y/plugins](https://github.com/p10ns11y/plugins).

Judgment plane only. Outer stays in **control-graph**. Blank-sheet Inner stays in **eva-emptiness**. This plugin does **not** copy those rituals.

```text
  /odysseus-core   one bottleneck, one mistake, one next   ← default, fastest
  /odysseus        full Navigator table                     ← when several smells
  /eva             Prior→Probe→Simulate→Score→ActOrAsk      ← emptiness only
  /mission-map     heading û_G / PERT                       ← path math only
```

## Odysseus (this harness)

| Field | Value |
|-------|--------|
| **ithaca** | Nail the deepest bottleneck in one pass; then hook the owner that already runs the graph |
| **waters** | novel-pressure for the *fast path*; calm for C/Rhai/tether — refuse those |
| **mistakes we refuse** | Circe (golden-cage plugin), Sirens (new “intelli OS”), Scylla (skill XOR plugin), Winds (always-on hooks) |
| **antidotes** | YAGNI · Incremental (copy this tree into `plugins/odysseus-navigator`) |
| **spirit** | Ithaca always; Metis only for the core-nailer shape |
| **cg_hook** | skip unless `/odysseus*` says multi-step |
| **eva_hook** | skip unless ≥2 emptiness signals |

## Do not ship (EVA / arch-machine / mission-map already own these)

| Refuse | Owner |
|--------|--------|
| C auth tether, PreToolUse hooks | `eva-emptiness` |
| Rhai background workflow | `eva-emptiness` / `arch-machine` |
| Three prior-fork agents | `eva-emptiness` Simulate |
| PERT / Monte-Carlo / Rust DAG | `mission-map` |
| `alwaysApply: true` lecture hook | — (Winds) |

## Install

SoT for the procedure is the **skills library** skill, not a second `SKILL.md` in this folder.

```bash
# 1. Copy this directory into the plugins marketplace clone
PLUGIN_SRC="<SKILLS_ROOT>/odysseus-navigator/plugin"
PLUGIN_DST="$HOME/Work/personal/plugins/odysseus-navigator"
rsync -a --delete --exclude skills/odysseus-navigator "$PLUGIN_SRC/" "$PLUGIN_DST/"

# 2. Symlink the portable skill (SoT) — sibling repos
mkdir -p "$PLUGIN_DST/skills"
ln -sfn "$HOME/Work/personal/skills/odysseus-navigator" "$PLUGIN_DST/skills/odysseus-navigator"

# 3. Marketplace row (edit plugins/.grok-plugin/marketplace.json) then:
grok plugin install "$PLUGIN_DST" --trust
# or: grok plugin install odysseus-navigator --trust
```

Dev symlink:

```bash
mkdir -p ~/.grok/plugins
ln -sfn "$PLUGIN_DST" ~/.grok/plugins/odysseus-navigator
```

Cursor: copy `cursor/commands/*.md` into the project or user commands dir; optional rule from the skills library (`rules/odysseus-navigator.mdc`).

## Slash commands

| Command | Job |
|---------|-----|
| `/odysseus-core` | Deep core: Ithaca + **one** bottleneck + at most one mistake + one next |
| `/odysseus` | Full Navigator (all matching mistakes) when several smells |

`$ARGUMENTS` = goal / plan / dump. If empty, ask one sentence for Ithaca, then continue.

## Tests

```bash
./test/test-thin.sh
# from skills library root:
node odysseus-navigator/scripts/validate-skill.mjs
```

## Layout

```text
plugin.json
commands/           # Grok slash
cursor/commands/    # Cursor slash (same contract, no Grok $ARGUMENTS)
agents/             # one Navigator persona — not three priors
skills/README.md    # symlink the library skill
test/test-thin.sh   # refuse C / Rhai / hooks / prior circus
```

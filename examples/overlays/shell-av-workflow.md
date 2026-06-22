# Overlay — shell `av` verify workflow

**Pairs with:** [verification-cockpit](../../verification-cockpit/SKILL.md)

**Repo:** [shellyxz/shell](https://github.com/p10ns11y/shell) (typical install: `~/.config/shell`)

## What this provides

| Piece | Path / command |
|-------|----------------|
| Verify launcher | `av` → `agent_verify` |
| Build launcher | `ab` |
| Tiered pane launch | `bin/lib/verify-launch.sh` |
| Golden-ratio layout | `bin/lib/verify-layout.sh` |
| Workflow root resolver | `bin/verify-workflow-root.sh` |
| Agent scan | `av --scan` → `agent_scan` in CMD pane |
| Generic fallback | `av --generic` |

## Install (host)

Clone or update the shell config repo to `~/.config/shell` and ensure `bin/` is on PATH (via your shell bootstrap / `path.contract`).

## Prerequisites for cockpits

- **tmux** — layouts run inside an existing tmux session
- **Ghostty** (or terminal of choice) — recommended for `t` / `z` workflow
- **lazygit** — optional; GIT pane degrades gracefully

## Per-project delegation

When a project has `.agents/verification/tmux-layout.sh`, `av` walks up from cwd and delegates to that layout instead of the generic cockpit.

Generate project layouts with the **verification-cockpit** skill in the target repo.

## Dogfood reference

The shell config repo ships `.agents/verification/` as a stress test (`check-shell-watch.sh`, template sync). See `arch-design/VERIFICATION.md` in that repo for full agent workflow docs.

## Symlink skill into a project

```bash
SKILLS_ROOT=~/skills
ln -sfn "$SKILLS_ROOT/verification-cockpit" /path/to/my-app/.cursor/skills/verification-cockpit
```

Then invoke the skill in that workspace to write `.agents/verification/*`.

---
name: premflow
description: >-
  Capture notes, wins, tasks, and focus into premflow without leaving the agent
  session. Use when the user dumps a thought, wants a note, win, todo, pomo, or
  evening review while coding; triggers: note, dump, capture, log this, premflow,
  remember this, task add, win, journal, review my day.
---

# premflow — stay in session, write the ledger

**Mission:** While coding with Grok, capture signal into **premflow** via the real CLI so you never context-switch to another app. Premflow owns the ledger; you own judgment.

## When to load

- User dumps a thought mid-work (“note this”, “remember”, “log that”)
- “Add a task”, “win”, “start a pomo”, “review my day”
- Mentions premflow / `~/.premflow`

## Immutable rules

1. **Write through the CLI** — `premflow note|win|task|pomo|…`. Do **not** hand-edit `~/.premflow/log.txt` unless the user explicitly asks.
2. **One line, one idea** — note/win/task bodies are single-line; newlines collapse on write.
3. **Never invent ledger lines** — no fake timestamps. If the binary is missing, say so and show the command.
4. **Prefer `premflow` on PATH**; else use the project binary `./build/premflow` when cwd is the premflow repo.
5. **Read with projections** — `premflow review` / `task list` before grepping the whole log.

## Binary resolution

```bash
# Prefer PATH
command -v premflow >/dev/null && PF=premflow || PF=./build/premflow
# If neither works: tell user to build (`make all` in premflow repo) or install.
```

## Capture map

| User intent | Command |
|-------------|---------|
| Dump / note / remember | `$PF note "TEXT"` |
| Win / gratitude | `$PF win "TEXT"` |
| Open task | `$PF task add "TEXT"` |
| Finish task #n | `$PF task done n` |
| List tasks | `$PF task list` |
| Focus block | `$PF pomo [plan] [context…]` e.g. `pomo 25 ship plugin` |
| Evening signal | `$PF review` (optional `review --full`) |
| Stats | `$PF stats` |
| Journal (editor) | `$PF journal` — only if user wants editor |

## In-session note dump (default path)

When the user pastes or speaks a thought to capture:

1. Condense to **one clear sentence** (keep their words when short).
2. Run:

   ```bash
   premflow note "their sentence here"
   ```

3. Confirm with the command output (`✓ Note saved` or equivalent) — do not claim success without running it.
4. Offer optional task/win if the note implies open work or a celebration.

## Pomo while pairing

```bash
premflow pomo 25 "context label for this work"
# or multi-chunk: premflow pomo 20,4,20,4 "deep work on X"
```

Live keys (user’s TTY): space/p pause, r restart segment, R reset, q quit.  
If no TTY, say so — do not block the session on a long timer unless they ask.

## Ledger contract (summary)

Full card: [references/ledger-contract.md](references/ledger-contract.md)

```text
[YYYY-MM-DD HH:MM] [TYPE] body
```

| TYPE | File |
|------|------|
| NOTE, WIN, POMO, DONE | `~/.premflow/log.txt` |
| TODO | `~/.premflow/todo.txt` |

**Anti-pattern:** nested `[DONE] [ts] [TODO] …` — never write that; CLI strips DONE titles cleanly.

## Coach (optional)

After capture or on “review my day”:

1. `premflow review`
2. `premflow task list` if priorities matter
3. Summarize signal (wins, open loops, next focus). Do not invent log facts.

## Install / discovery (Grok)

This skill lives at `~/Work/personal/skills/premflow/`.

```bash
mkdir -p ~/.grok/skills
ln -sfn ~/Work/personal/skills/premflow ~/.grok/skills/premflow
```

Or add to `~/.grok/config.toml`:

```toml
[skills]
paths = ["~/Work/personal/skills"]
```

Reload session or Plugins/Skills UI so Grok picks it up.

## Anti-goals

- Embedding local ollama into premflow
- Replacing the CLI with chat-only “memory”
- Bulk rewriting historical log lines

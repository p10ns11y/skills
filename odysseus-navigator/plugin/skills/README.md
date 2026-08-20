# skills/

Procedure SoT lives in the portable library, not a second copy here (no dual-edit).

```bash
SKILLS_ROOT="${SKILLS_ROOT:-$HOME/Work/personal/skills}"
mkdir -p "$(dirname "$0")"
ln -sfn "$SKILLS_ROOT/odysseus-navigator" "$(cd "$(dirname "$0")" && pwd)/odysseus-navigator"
```

Grok loads `skills/odysseus-navigator/SKILL.md` after that link exists. Slash commands still work without it — they carry the fast path.

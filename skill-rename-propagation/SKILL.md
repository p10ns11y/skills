---
name: skill-rename-propagation
description: >-
  Rename a skill folder, frontmatter name, Cursor rules, validators, README
  catalog, pack scripts, and consuming-repo references in one pass. Use when
  renaming skills (e.g. looper → control-graph) or after folder moves.
---

# skill-rename-propagation

```text
// Inputs
OLD, NEW  // kebab-case skill names
LIB       // skills library root
PROJECTS  // optional list of consuming checkouts

// Axioms
A1  One pass: grep → rewrite → validate → commit (don't half-rename)
A2  Keep discovery alias in description for ≥1 release if OLD was public
A3  Update validators that hardcode name === OLD
A4  Symlinks ~/.cursor/skills/OLD and rules/OLD.mdc must be repointed
```

---

## Checklist

```text
[ ] 1. git mv LIB/OLD LIB/NEW  (and rules/OLD.mdc → rules/NEW.mdc if any)
[ ] 2. Frontmatter name: NEW
[ ] 3. Body titles, links, scripts paths
[ ] 4. Optional redirect OLD/SKILL.md → NEW (legacy discovery)
[ ] 5. README catalog + QUALITY + pack scripts (master-planner pull-skills.sh)
[ ] 6. Workflows .md/.rhai skill_chain strings
[ ] 7. Consuming projects: AGENTS.md, .agents/skills symlinks
[ ] 8. Run skill validator if present
[ ] 9. rg OLD across LIB — residual only intentional aliases
[ ] 10. Commit with clear rename message
```

## Commands

```bash
OLD=looper NEW=control-graph
LIB="${SKILLS_ROOT:-$HOME/Work/personal/skills}"
cd "$LIB"

# find
rg -n --glob '!**/.git/**' --glob '!archive/**' "\\b${OLD}\\b" || true

# after git mv + content rewrites
node "$NEW/scripts/validate-skill.mjs" 2>/dev/null || true
rg -n --glob '!**/.git/**' --glob '!archive/**' --glob '!**/$OLD/**' "\\b${OLD}\\b" || true
```

### Consuming repo

```bash
# repoint symlink
ln -sfn "$LIB/$NEW" .agents/skills/$NEW
rm -f .agents/skills/$OLD
# fix AGENTS.md table rows
```

## Done when

- [ ] `name:` frontmatter is NEW  
- [ ] No accidental OLD paths in active (non-archive, non-alias) files  
- [ ] Validator passes  
- [ ] User symlinks documented  

## Anti-patterns

| ¬ | Do |
|---|-----|
| rename folder only | break frontmatter + rules |
| leave pack scripts on OLD | agents pull missing skill |
| delete OLD triggers immediately | keep alias in description/redirect |

Related: [dual-copy-skill-publish](../dual-copy-skill-publish/SKILL.md) · [author-workflow-skill](../author-workflow-skill/SKILL.md)

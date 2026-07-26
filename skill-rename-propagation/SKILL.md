---
name: skill-rename-propagation
description: >-
  One-pass rename of a skill: folder, frontmatter name, Cursor rules, validators,
  README catalog, pack scripts, workflows, and consuming-repo references. Use when
  renaming skills (e.g. looper → control-graph) or after folder moves. Triggers:
  skill rename, rename propagation, rename skill, looper rename.
---

# skill-rename-propagation

> **Load rule:** Formal checklist is SoT. Aligns with [QUALITY.md](../QUALITY.md) rename policy.

```text
// Inputs
OLD, NEW  // kebab-case skill names
LIB       // skills library root
PROJECTS  // optional consuming checkouts

// Axioms
A1  One pass: grep → rewrite → validate → commit  (no half-rename)
A2  Keep discovery alias in description for ≥1 release if OLD was public
A3  Update validators that hardcode name === OLD
A4  Symlinks ~/.cursor/skills/OLD and rules/OLD.mdc must be repointed
A5  Archive may keep OLD paths as history — do not "fix" archive unless intentional
A6  Evaluate(δ) ≔ (C, E, η)
```

Related: [dual-copy-skill-publish](../dual-copy-skill-publish/SKILL.md) · [author-workflow-skill](../author-workflow-skill/SKILL.md) · [master-planner](../master-planner/SKILL.md).

---

## Use / skip

| Use | Skip |
|-----|------|
| renaming skill folder/public name | cosmetic title-only in body |
| after `git mv` left broken links | pure content edit without name change |
| pack/README still point at OLD | |

---

## One-pass checklist

```text
[ ] 1. git mv LIB/OLD LIB/NEW  (+ rules/OLD.mdc → rules/NEW.mdc if any)
[ ] 2. Frontmatter name: NEW
[ ] 3. Body titles, links, script paths
[ ] 4. Optional redirect OLD/SKILL.md → NEW (legacy discovery) + description alias
[ ] 5. README catalog + QUALITY + pack scripts (master-planner pull-skills.sh)
[ ] 6. Workflows .md/.rhai skill_chain strings
[ ] 7. Consuming projects: AGENTS.md, .agents/skills symlinks
[ ] 8. Run skill validator if present
[ ] 9. rg OLD across LIB — residual only intentional aliases / archive / redirect
[ ] 10. Commit with clear rename message (push=HITL)
```

### Commands

```bash
OLD=looper NEW=control-graph
LIB="${SKILLS_ROOT:-$HOME/Work/personal/skills}"
cd "$LIB"

rg -n --glob '!**/.git/**' --glob '!archive/**' "\\b${OLD}\\b" || true

# after git mv + content rewrites
node "$NEW/scripts/validate-skill.mjs" 2>/dev/null || true
rg -n --glob '!**/.git/**' --glob '!archive/**' --glob "!**/${OLD}/**" "\\b${OLD}\\b" || true
```

### Consuming repo

```bash
ln -sfn "$LIB/$NEW" .agents/skills/$NEW
rm -f .agents/skills/$OLD
# fix AGENTS.md table rows
```

---

## Done when

- [ ] `name:` frontmatter is NEW  
- [ ] No accidental OLD paths in active (non-archive, non-alias, non-redirect) files  
- [ ] Validator passes if present  
- [ ] User symlinks / pack scripts documented or updated  
- [ ] Commit created  

## Anti-patterns

| ¬ | Do |
|---|-----|
| rename folder only | break frontmatter + rules + packs |
| leave pack scripts on OLD | agents pull missing skill |
| delete OLD triggers immediately | keep alias in description/redirect ≥1 release |
| mass-edit archive distill history | leave archive; note supersession |

**Done_when cmds:** `rg -n '^name:' "$NEW/SKILL.md"` · `rg -n "\\b$OLD\\b" --glob '!archive/**' --glob "!$OLD/**"` · validator exit 0.

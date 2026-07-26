---
name: dual-copy-skill-publish
description: >-
  Publish a skill to both the consuming project (.agents/skills or .cursor/skills)
  and the portable skills library repo, with matching content, index updates, and
  hash verification. Use when promoting a skill from a project into the shared
  library or syncing both copies after edits.
---

# dual-copy-skill-publish

> Prefer **one canonical library tree** + symlink into projects when possible.  
> Use this skill when policy requires **two git-tracked trees** (project copy + library copy).

```text
// Signature
ProjectSkill  ≔ <project>/.agents/skills/<name>/   // or .cursor/skills/
LibrarySkill  ≔ {SKILLS_ROOT}/<name>/              // e.g. ~/Work/personal/skills
SoT           ≔ choose one write source per edit pass; then sync

// Axioms
A1  Never leave ProjectSkill ≠ LibrarySkill after publish (byte-identical SKILL tree)
A2  Update indexes (README catalog, AGENTS.md) in both repos when name/description changes
A3  No secrets / absolute home paths in skill bodies — use ~ or {REPO_ROOT}
A4  Push only with user-approved git_write/network
```

---

## When / skip

| Use | Skip |
|-----|------|
| skill must live in project git **and** skills library git | symlink-only install is enough |
| promoting in-repo skill outward | pure local experiment |
| fixing drift between two copies | one-off edit you will not publish |

---

## Steps

1. **Orient**
   ```bash
   echo "PROJECT=$(pwd)"
   echo "SKILLS_ROOT=${SKILLS_ROOT:-$HOME/Work/personal/skills}"
   ls .agents/skills 2>/dev/null; ls .cursor/skills 2>/dev/null
   test -d "$SKILLS_ROOT/.git"
   ```

2. **Choose SoT for this pass** — usually edit library first for portable skills; project-first only if project-specific and then strip overlays.

3. **Write / update skill tree** under SoT:
   - `SKILL.md` with third-person `description` + triggers  
   - optional `references/`, `scripts/`, `templates/`  
   - meet [QUALITY.md](../QUALITY.md)

4. **Sync other copy** (identical tree):
   ```bash
   NAME=<skill-name>
   SRC=…   # SoT path
   DST=…   # other path
   rsync -a --delete --exclude .git "$SRC/" "$DST/"
   # or: rm -rf "$DST" && cp -a "$SRC" "$DST"
   ```
   Prefer **symlink** `DST → SRC` when the project allows non-vendored skills:
   ```bash
   ln -sfn "$SKILLS_ROOT/$NAME" .agents/skills/$NAME
   ```

5. **Indexes**
   - Library [README.md](../README.md) catalog row if new  
   - Project `AGENTS.md` active-skills table  
   - master-planner packs if pack-listed  

6. **Validate**
   ```bash
   # if skill ships validator
   node "$SKILLS_ROOT/$NAME/scripts/validate-skill.mjs" 2>/dev/null || true
   # hash compare when dual-copy (not symlink)
   diff -qr "$SRC" "$DST"
   ```

7. **Commit / push** (each repo separately; conventional messages; user approval for push):
   ```bash
   # library
   cd "$SKILLS_ROOT" && git status && git add "$NAME" README.md && git commit -m "feat($NAME): …"
   # project
   cd "$PROJECT" && git add .agents/skills/$NAME AGENTS.md && git commit -m "chore(skills): sync $NAME"
   ```

---

## Done when

- [ ] Both trees identical **or** project uses symlink to library  
- [ ] Catalogs updated  
- [ ] Validator (if any) passes  
- [ ] Commits created; push only if user requested  

## Anti-patterns

| ¬ | Do |
|---|-----|
| edit only project forever | drift; sync or symlink |
| `cp` without `--delete` | stale files remain in DST |
| push secrets | strip before publish |
| one commit across two repos | separate histories |

Related: [author-workflow-skill](../author-workflow-skill/SKILL.md) · [skill-rename-propagation](../skill-rename-propagation/SKILL.md) · [master-planner](../master-planner/SKILL.md)

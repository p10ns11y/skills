---
name: dual-copy-skill-publish
description: >-
  Publish a project-born skill into both the consuming project tree and the
  portable skills library with matching content, index updates, and hash/symlink
  verification. Use when promoting a project-only skill outward or fixing drift
  between two git-tracked copies. Not for portable library skills (use symlink
  via master-planner). Triggers: dual-copy, dual publish, skill publish, project
  skill sync.
---

# dual-copy-skill-publish

> **Load rule:** Formal SoT. Prefer **one canonical library + symlink** for portable skills. This skill applies only when policy requires **two git-tracked trees** (project-born skill).

```text
// Signature
ProjectSkill  ≔ <project>/.agents/skills/<name>/   // or .cursor/skills/
LibrarySkill  ≔ {SKILLS_ROOT}/<name>/              // e.g. ~/Work/personal/skills
SoT           ≔ single write source per edit pass; then sync
Kind ∈ { project_born, portable_library }

// Axioms
A1  Scope = project_born only  — portable skills → symlink ([master-planner](../master-planner/SKILL.md)); never dual-edit portable bodies
A2  After publish: ProjectSkill ≡ LibrarySkill  (byte-identical tree)  ∨  ProjectSkill → symlink(LibrarySkill) when vendoring allowed
A3  Indexes updated both sides when name/description changes (README, AGENTS.md)
A4  No secrets / absolute home paths in bodies — use ~ or {REPO_ROOT}
A5  Push only with explicit user approval (shared remotes)
A6  Evaluate(δ) ≔ (Correctness, Effectiveness, Efficiency)
```

Related: [skill-rename-propagation](../skill-rename-propagation/SKILL.md) · [master-planner](../master-planner/SKILL.md) · [author-workflow-skill](../author-workflow-skill/SKILL.md) · [session-unit-order](../session-unit-order/SKILL.md) (example project-born skill).

---

## Use / skip

| Use | Skip |
|-----|------|
| skill **born in project** must stay in project git **and** land in library git | portable skill → `pull-skills.sh` / symlink only |
| promoting in-repo skill outward | pure local experiment you will not publish |
| fixing drift between two intentional copies | one-off edit with no publish intent |
| | dual-editing a portable `SKILL.md` for one project (use overlays) |

---

## Procedure

```text
1 Orient → 2 Classify kind → 3 Choose SoT → 4 Write → 5 Sync → 6 Indexes → 7 Validate → 8 Commit (push=HITL)
```

### 1. Orient

```bash
echo "PROJECT=$(pwd)"
echo "SKILLS_ROOT=${SKILLS_ROOT:-$HOME/Work/personal/skills}"
ls .agents/skills 2>/dev/null; ls .cursor/skills 2>/dev/null
test -d "${SKILLS_ROOT:-$HOME/Work/personal/skills}/.git"
```

### 2. Classify

| Kind | Signal | Action |
|------|--------|--------|
| **project_born** | encodes project-only architecture/incident; kept in project git | this skill |
| **portable_library** | general procedure; lives in skills repo | symlink via master-planner — **stop here** |

### 3. SoT for this pass

- Default: edit **project** first when project-born, then strip project-only overlays before library copy  
- Or: edit **library** first when generalizing an already-portable extract  
- Never edit both independently in the same pass

### 4. Write under SoT

- `SKILL.md`: third-person `description` + triggers  
- optional `references/`, `scripts/`, `templates/`  
- meet [QUALITY.md](../QUALITY.md)

### 5. Sync other tree

```bash
NAME=<skill-name>
SRC=…   # SoT
DST=…   # other
# dual-copy (two git trees):
rsync -a --delete --exclude .git "$SRC/" "$DST/"
# OR when project may vendor via symlink (portable after promotion):
ln -sfn "$SKILLS_ROOT/$NAME" .agents/skills/$NAME
```

`rsync` without `--delete` leaves stale DST files — always `--delete` when dual-copying.

### 6. Indexes

- Library [README.md](../README.md) catalog row if new  
- Project `AGENTS.md` active-skills table  
- master-planner packs only if pack-listed  

### 7. Validate

```bash
node "$SKILLS_ROOT/$NAME/scripts/validate-skill.mjs" 2>/dev/null || true
# dual-copy (not symlink):
diff -qr "$SRC" "$DST"
# optional hash:
# find "$SRC" -type f -exec sha256sum {} \; | sort | sha256sum
```

### 8. Commit (each repo separately)

```bash
cd "$SKILLS_ROOT" && git add "$NAME" README.md && git status
# commit with conventional message — push only if user requested
cd "$PROJECT" && git add .agents/skills/$NAME AGENTS.md && git status
```

---

## Done when

- [ ] Kind was project_born (or intentional dual-track documented)  
- [ ] Trees identical **or** project uses symlink to library  
- [ ] Catalogs updated  
- [ ] Validator (if any) passes; `diff -qr` clean when dual-copy  
- [ ] Commits created; **push only if user requested**  

## Anti-patterns

| ¬ | Do |
|---|-----|
| dual-edit portable library skill per project | overlays + symlink |
| edit only project forever | drift; sync or symlink |
| `cp`/`rsync` without `--delete` | stale files in DST |
| one commit across two repos | separate histories |
| push secrets / absolute paths | scrub first |
| reinstall archive distill stubs | rewrite as real procedure |

**Done_when cmds:** `diff -qr "$SRC" "$DST"` · `test -f "$SKILLS_ROOT/$NAME/SKILL.md"` · `rg -n '^name:' "$NAME/SKILL.md"`.

---
name: tidy-commit-push
description: >-
  Inspect git status, remove junk/legacy/secrets from the commit set, craft a
  conventional commit message, and commit locally; push only with explicit user
  approval. Use before shipping a logical unit of work. Triggers: tidy commit,
  conventional commit, pre-push hygiene, commit and push.
---

# tidy-commit-push

> **Load rule:** Formal SoT. Compose with [agent-orchestrator](../agent-orchestrator/SKILL.md) report and [split-to-prs](../split-to-prs/SKILL.md) for multi-PR ships.

```text
// Axioms
A1  Never commit .env, credentials, private keys, large binaries by accident
A2  One logical change per commit (or explicit multi-commit plan)
A3  Push = HITL  — only with user approval on shared remotes / protected branches
A4  Prefer HEREDOC commit messages; match repo history style (git log -5)
A5  Never --force to main/master unless explicit disaster recovery + approval
A6  Evaluate(δ) ≔ (C, E, η)
```

---

## Use / skip

| Use | Skip |
|-----|------|
| ready to record a coherent unit | WIP still broken with no message yet |
| pre-PR hygiene | user said do not commit |
| after agent wave | secrets present and unredacted |

---

## Procedure

```text
1 Inspect → 2 Tidy stage → 3 Message → 4 Commit → 5 Push? (HITL) → 6 PR? (HITL)
```

### 1. Inspect

```bash
git status
git diff
git diff --staged
git log -5 --oneline
git branch -vv
```

### 2. Tidy staging set

- Unstage junk: `*.log`, `node_modules`, build outs, editor swap  
- Remove legacy paths only if intentional delete is part of the change  
- **Privacy:** no tokens/keys; if staged → `git restore --staged` and scrub  
- Prefer `git add <paths>` over blind `git add .` when mixed worktrees  

### 3. Message

Conventional if repo uses it: `type(scope): summary`  
Types: `feat` `fix` `chore` `docs` `refactor` `test` `perf`

### 4. Commit (local default)

```bash
git commit -m "$(cat <<'EOF'
type(scope): short summary

Optional body — why, not how.
EOF
)"
```

### 5. Push — **only if user requested**

```bash
git push -u origin HEAD
# never --force to main/master unless explicit disaster recovery + approval
```

### 6. PR — only if requested: `gh pr create …`

---

## Done when

- [ ] `git status` clean or only intentional leftovers listed  
- [ ] Commit exists with accurate message  
- [ ] Push/PR **only** per user request  

## Anti-patterns

| ¬ | Do |
|---|-----|
| commit + push secrets | scrub; rotate if leaked |
| "WIP" on main without ask | feature branch |
| amend published commit | new commit |
| force-push shared branch | recover with user plan |
| silent agent push | wait for HITL |

Related: [agent-orchestrator](../agent-orchestrator/SKILL.md) · [split-to-prs](../split-to-prs/SKILL.md) · [git-worktrees](../git-worktrees/SKILL.md)

**Done_when cmds:** `git status -sb` · `git log -1 --oneline` · (optional) `git push` only after confirm.

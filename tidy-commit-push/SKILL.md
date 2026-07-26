---
name: tidy-commit-push
description: >-
  Inspect git status, remove junk/legacy secrets from the commit set, craft a
  conventional commit message, and optionally push. Use before shipping a
  logical unit of work; not for secret-laden dumps or force-push to shared main.
---

# tidy-commit-push

```text
// Axioms
A1  Never commit .env, credentials, private keys, large binaries by accident
A2  One logical change per commit (or explicit multi-commit plan)
A3  Push only with user approval when shared remotes / protected branches
A4  Prefer HEREDOC commit messages; match repo history style (git log -5)
```

---

## When / skip

| Use | Skip |
|-----|------|
| ready to record a coherent unit | WIP still broken with no message yet |
| pre-PR hygiene | user said do not commit |
| after agent wave | secrets present and unredacted |

---

## Steps

1. **Inspect**
   ```bash
   git status
   git diff
   git diff --staged
   git log -5 --oneline
   git branch -vv
   ```

2. **Tidy staging set**
   - Unstage junk: `*.log`, `node_modules`, build outs, editor swap  
   - Remove legacy paths if intentional delete is part of the change  
   - **Privacy:** ensure no tokens/keys; if staged, `git restore --staged` and scrub  
   - Prefer `git add <paths>` over blind `git add .` when mixed worktrees  

3. **Message** — conventional if repo uses it: `type(scope): summary`  
   Types: `feat` `fix` `chore` `docs` `refactor` `test` `perf`

4. **Commit**
   ```bash
   git commit -m "$(cat <<'EOF'
   type(scope): short summary

   Optional body — why, not how.
   EOF
   )"
   ```

5. **Push** only if requested:
   ```bash
   git push -u origin HEAD
   # never --force to main/master unless explicit disaster recovery + approval
   ```

6. **PR** only if requested: `gh pr create …`

---

## Done when

- [ ] `git status` clean or only intentional leftovers listed  
- [ ] Commit exists with accurate message  
- [ ] Push/PR only per user request  

## Anti-patterns

| ¬ | Do |
|---|-----|
| commit + push secrets | scrub; rotate if leaked |
| "WIP" on main without ask | feature branch |
| amend published commit | new commit |
| force-push shared branch | recover with user plan |

Related: [agent-orchestrator](../agent-orchestrator/SKILL.md) report phase · [split-to-prs](../split-to-prs/SKILL.md)

---
name: adversarial-audit
description: >-
  Adversarial verification of claimed work: read shipped modules (not memory),
  grep wiring and approvals, run tests, demand evidence before pass verdict.
  Use when reviewing agent output, PRs, or security-sensitive changes before merge.
---

# adversarial-audit

```text
// Role
Reviewer ⊥ ImplementerContext   // fresh; try to refute claims

// Axioms
A1  Default real=false until independent evidence
A2  Read shipped files + run commands — never trust summary alone
A3  Verdict requires: scope check + tests/cmds + explicit gaps
A4  Compose with agent-orchestrator VERIFY and control-graph REVIEW_GATE
```

---

## When / skip

| Use | Skip |
|-----|------|
| worker/agent claimed "done" | pure design chat, no diff |
| pre-merge high stakes | typo you wrote yourself 30s ago (still run lint if easy) |
| security/auth/deps changes | |

---

## Procedure

1. **Scope inventory**
   ```bash
   git diff <base>...HEAD --stat
   git log <base>..HEAD --oneline
   ```
   List claimed outcomes from brief/PR body.

2. **Read shipped code** — open every file that implements a claim; grep for wiring:
   ```bash
   rg -n "pattern|approval|TODO|FIXME|XXX" --glob '!**/node_modules/**'
   ```

3. **Run verify commands** from brief / AGENTS.md / CI:
   ```bash
   # examples — use project actuals
   pnpm type-check && pnpm lint
   cargo test -q
   ```
   Capture exit codes.

4. **Attack claims**
   - Does diff match the claim?  
   - Missing error paths, authz, cleanup?  
   - Tests that don't exercise the change?  
   - Secrets or overly broad permissions?

5. **Verdict artifact**

```markdown
## Adversarial verdict
**Claims reviewed:** …
**Evidence:** files read · cmds + exit
**Confirmed:** …
**Refuted / gaps:** …
**Risk:** low|med|high
**Decision:** pass | fix-required | blocked
```

---

## Done when

- [ ] Independent reads + at least one automated check (or documented why impossible)  
- [ ] Explicit pass/fix with gaps list  
- [ ] No merge recommendation on testimony alone  

## Anti-patterns

| ¬ | Do |
|---|-----|
| "LGTM" from PR text | open the files |
| same context that implemented | new review role / session |
| ignore failing tests | fail closed |

Related: [agent-orchestrator](../agent-orchestrator/SKILL.md) · [control-graph](../control-graph/SKILL.md) · [fix-dependency-security](../fix-dependency-security/SKILL.md)

---
name: gt-flow
description: >-
  Graphite (gt) stacking decision and execution: diagnose coupling, honestly
  recommend when gt is overkill (plain branches / split-to-prs / sequential),
  and when chosen enforce commit-in-generation + two-phase handoff + backup refs
  so code is never lost. Use for gt/graphite/stack/submit --stack, execute-plan
  assembly, concurrent agents, or PR planning.
---

# gt-flow

> **Load rule:** Formal SoT. Long recipes → [references/english-procedure.md](references/english-procedure.md) only if needed.

```text
// Tools
Git     ≔ history + branches
gt      ≔ stack graph + restack/submit UX
Worktree ≔ physical isolation (where)

// Compatible (gt ≥1.8.4+) but not seamless: branch checked out in ≤1 WT;
// gt refuses mutate branch owned by another WT; gt undo is per-WT.

// Axioms (zero-lost-code)
A1  Commit in generation env before teardown
A2  Push branches; record authoritative SHAs
A3  Tear down WT before mutating that branch ref elsewhere
A4  gt log before stack-wide commands
A5  Two-phase handoff: agent push → human primary shell gt/gh
A6  Backup refs before risky mutation
A7  Per-slice escape branches always exist
A8  Never cp from WT to integrate
```

Pair: [git-worktrees](../git-worktrees/SKILL.md) · [split-to-prs](../split-to-prs/SKILL.md) · [agent-orchestrator](../agent-orchestrator/SKILL.md).

---

## Decision procedure (always first)

```text
1. Intent → planned slices (files each)
2. Coupling: overlap + core files → High|Med|Low
3. Context: primary authenticated shell? agent WT? gt present+auth?
4. Declare one of:
   gt_recommended | gt_overkill | hybrid_handoff
```

| Verdict | When | Next |
|---------|------|------|
| **gt_recommended** | low coupling · clean boundaries · human in primary | single-WT gt recipe |
| **gt_overkill** | high core overlap · agent-only auth mismatch · tiny scope · max recoverability | plain PR / sequential / late `gt split` |
| **hybrid_handoff** | agent gen + human land (default ambitious agentic) | per-PR branches pushed → user `fetch` + gt/gh |

State 1-sentence rationale (coupling or context). Confirm with user before mutating stacks.

### Coupling score

- **High:** heavy overlap on core (shared lib, central state, AGENTS, build configs) or >40% slices share 1–3 files  
- **Medium:** some shared surface, clear new-module boundaries  
- **Low:** clean functional splits  

---

## Mode cheat sheet

| Situation | Choice |
|-----------|--------|
| independent PRs or high coupling | plain git or linear then `gt split` |
| stacked PRs, one thing, primary shell | **gt single WT** (sweet spot) |
| parallel independent + isolation | gt + multi WT + `gt log` discipline |
| agents + human submit | **hybrid** |
| late coupling discovery | `gt fold` or finish linear → `gt split` |

---

## Zero-lost-code contract (always)

1. Commit where code was written  
2. Push (`--force-with-lease` on resume)  
3. Record `commit_sha`  
4. Remove WT before rewriting that branch elsewhere  
5. `gt log` before sync/restack/submit/modify/create-on  
6. Print Phase-1 agent cmds + Phase-2 primary cmds  
7. `refs/backup/…` or `backup/…` branches pre-risk  
8. Keep `execute-plan/…-pr-N-…` style escape branches  
9. State/transcript survives for resume  
10. Hygiene after ([git-worktrees disk-hygiene](../git-worktrees/references/disk-hygiene.md))  

If any cannot be satisfied → simpler path + document why.

---

## Command anchors

```text
gt log | gt ls          # ownership + stack — before stack-wide ops
gt create [-am] [--onto parent]
gt submit --stack | gt ss
gt sync · gt restack    # from each WT that owns part of stack
gt modify -a · gt fold · gt split -c|-f|-h
gt undo                 # this WT only
gt track | untrack
gt up/down/top/bottom/checkout
```

---

## Anti-patterns

| ¬ | Do |
|---|-----|
| gt during high coupling agent thrash | hybrid or overkill path |
| assume agent shell has gt auth | handoff to primary |
| mutate branch checked out elsewhere | `gt log`; work from owner WT or `--onto` |
| integrate via `cp` | commit+merge/cherry-pick |
| drop per-PR branches after linear | keep escape hatches |

**Done when:** explicit verdict + rationale; if shipping — SHAs pushed; handoff text for human shell if hybrid.

Recipes/recovery: [references/english-procedure.md](references/english-procedure.md).

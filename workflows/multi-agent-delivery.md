---
name: multi-agent-delivery
description: >-
  Portable multi-agent delivery: triage, control-graph outer phases, worktree
  isolation, optional parallel workers, verify, split to reviewable PRs.
kind: workflow
skill_chain:
  - agent-orchestrator
  - control-graph
  - git-worktrees
  - concurrent-cli-agents
  - split-to-prs
---

# multi-agent-delivery

## When

Non-trivial multi-file or multi-worker delivery with thrash risk.

## Skill chain (all exist in this library)

1. `agent-orchestrator` — single-shot vs light vs full; briefs  
2. `control-graph` — Outer SM/loop + Inner DAG; budgets; HITL  
3. `git-worktrees` — isolate workers; merge not `cp`  
4. `concurrent-cli-agents` — parallel only if independent  
5. `split-to-prs` — reviewable chunks  

## Phases

| Phase | Owner skill | Outcome |
|-------|-------------|---------|
| Triage | agent-orchestrator | single-shot exit or full path |
| Orient+Plan | control-graph | Control Card + success criteria + verify cmds |
| Execute | control-graph + worktrees (+ concurrent if independent) | commits on agent branches |
| Verify | control-graph REVIEW | orchestrator runs verify cmds |
| Integrate | git-worktrees + split-to-prs | merged / stacked PRs |

## Install

```bash
cp workflows/multi-agent-delivery.rhai ~/.grok/workflows/
# or project: .grok/workflows/
```

# gt-flow — English recipes

Load **only if** [../SKILL.md](../SKILL.md) decision tables are not enough.

## Mental model

| Tool | Solves | Directory | Stack tracking |
|------|--------|-----------|----------------|
| Plain Git | history | usually 1 tree | mental |
| Graphite `gt` | stacked PRs, restack, submit UX | designed 1 tree; multi-WT since 1.8.4+ | parent/child stack |
| Git worktrees | physical isolation | many trees, one object DB | none |

Graphite + worktrees compose when you respect: one branch checkout per tree; run stack-wide commands from owning trees; `gt log` first.

## Official gt worktree guardrails (v1.8.4+)

- Fully supports multiple worktrees  
- Will **not** mutate a branch checked out in another worktree (safety)  
- `gt log` shows which worktree owns each branch  
- `gt undo` is **per-worktree**  
- Prefer not splitting one stack across many WTs; if you do, sync/restack per owning tree  
- `gt create --onto <branch>` when parent lives in another WT  

## Single-worktree gt (human primary)

```bash
gt trunk
# slice 1…
gt add -A && gt create -m "part 1: …"
gt create -am "part 2: …"
gt submit --stack
# on feedback: gt checkout <downstack> && gt modify -a && gt submit --stack
# trunk moved: gt sync && gt restack
```

## Hybrid agentic (default here)

1. Agents in isolated WTs/clones: implement → commit → push → record SHA  
2. User primary authenticated shell:

```bash
git fetch origin
# Option A: linear then split
git checkout -b review/plan-xxx origin/<linear>
gt split --by-commit   # or --by-file / --by-hunk

# Option B: track per-PR branches into a stack
gt create <pr1-branch> --onto main
# … stack order …
gt submit --stack
```

Always leave per-PR escape branches pushed.

## When gt overkill

Follow [split-to-prs](../../split-to-prs/SKILL.md) or sequential waves on one branch, then optional late `gt split`. Snapshot with backup refs first.

## Recovery

| Problem | Action |
|---------|--------|
| code only in doomed WT | commit+push **before** remove |
| stack confused across WTs | `gt log` each WT; restack from owners |
| crash mid-handoff | fetch per-PR branches; reconstruct with track/create |
| `gt undo` unexpected | wrong worktree — undo is local to that WT |

## Integration

- execute-plan: dual-mode + Subagent Worktree Protocol — consult this skill at assembly  
- git-worktrees: *where* code lives  
- split-to-prs: coupling escape hatch  
- agent-orchestrator: surface coupling early; print handoff  

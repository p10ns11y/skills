---
name: master-planner
description: >-
  Builds a project master plan as an interconnected web of friction-removing
  automations aimed at impossible missions. Resolves the skills library from
  SKILLS_ROOT, ~/Work/personal/skills, or clones https://github.com/p10ns11y/skills
  when local is missing; pulls a pack into cwd, Orwell-tweaks overlays, and adds
  ontology for large/complex repos. Use for master plans, skill pull/tweak,
  project skill packs, ontology, or /master-planner.
---

# Master Planner

> **Load rule:** Formal SoT below. Orwell/ontology depth → [references/](references/) only if needed.

```text
// Mission
MasterPlan ≔ friction-removing automation web for an impossible mission (live skill web — not slides)

// Resolve
SKILLS_ROOT → ~/Work/personal/skills → clone https://github.com/p10ns11y/skills
Project ──symlink──► .agents/skills/ | .cursor/skills/
Portable bodies: never fork — overlays only
Project-born skills: keep in-tree; publish via [dual-copy-skill-publish](../dual-copy-skill-publish/SKILL.md)

// Axioms
A1  Plan ⇔ removes friction (tokens | handoffs | rediscovery | unsafe defaults)
A2  Symlink portable skills; overlay tweaks; never dual-edit portable SKILL.md
A3  Ontology only when complex (≥2 of: multi-crate, agent contracts, wrong-file risk, cross-module invariants)
A4  Verify pack + project checks before "done"
```

**Remote:** [p10ns11y/skills](https://github.com/p10ns11y/skills). **Companions:** [ai-optimization](../ai-optimization/SKILL.md) · [fusion-sage](../fusion-sage/SKILL.md) · [higher-order-decision-architect](../higher-order-decision-architect/SKILL.md) · [stellar-spacemap](../stellar-spacemap/SKILL.md) · [agent-orchestrator](../agent-orchestrator/SKILL.md)

---

## When to run

| Signal | Action |
|--------|--------|
| “Master plan”, “skill pack”, “pull skills”, `/master-planner` | Full workflow |
| New repo / cold agent setup | Pull + AGENTS.md + verify |
| Large complex repo, agents lose the map | Add/refresh ontology |
| Overlays stale vs shipped architecture | Tweak overlays only |

**Skip:** one-file typo, single bugfix with known path.

---

## Workflow (do in order)

```
- [ ] 1. Orient — cwd, AGENTS.md, existing .agents/skills, mission one-liner
- [ ] 2. Scan library — list skills; map pack to stack (see Pack router)
- [ ] 3. Pull — symlink missing skills; keep in-repo skills that are project-owned
- [ ] 4. Tweak — Orwell + action + diagram + compress overlays (see Tweak law)
- [ ] 5. Ontology — if complex: INDEX + graph (+ GRAPH.md); else skip
- [ ] 6. Wire — AGENTS.md active-skills table + verify block
- [ ] 7. Verify — script + project checks; report gaps
```

### 1. Orient

```bash
pwd
test -f AGENTS.md && head -80 AGENTS.md
ls -la .agents/skills 2>/dev/null || ls -la .cursor/skills 2>/dev/null
```

Capture: **mission** (one sentence) · **stack signals** (Cargo.toml, install.sh, package.json, …) · **already wired skills**.

### 2. Scan library

```bash
# Resolves local or clones https://github.com/p10ns11y/skills
SKILLS_ROOT="$(./scripts/resolve-skills-root.sh)"
ls "$SKILLS_ROOT" | grep -vE '^(examples|rules|\.git|LICENSE|README)'
```

Read library [README.md](../README.md) pack table. Prefer **starter packs** over one-off picks.

### 3. Pull

```bash
# Resolves SKILLS_ROOT (local → remote clone) then symlinks
./scripts/pull-skills.sh --project "$(pwd)" --pack <pack-name>
./scripts/pull-skills.sh --project "$(pwd)" --skills ai-optimization,fusion-sage,...
# force remote even if a stale local path exists:
./scripts/pull-skills.sh --project "$(pwd)" --pack arch-guardian --from-remote
```

Rules:

- Symlink into `.agents/skills/<name>` (arch-machine style) or `.cursor/skills/` — match repo convention.
- **Never edit** portable `SKILL.md` bodies for one project — use `.agents/overlays/` or `examples/overlays/`.
- Keep **in-repo** skills (not symlinks) when they encode project-only architecture (e.g. eagle TEA).

### 4. Tweak (overlays)

Load [references/orwell-tweak.md](references/orwell-tweak.md). For each pulled skill that needs local coords:

| Write | Path |
|-------|------|
| Relevance / never-compress | `.agents/overlays/<project>-ai-optimization.md` |
| Fused aggregates | `.agents/overlays/<project>-fusion-sage.md` |
| Decision zones | `.agents/overlays/<project>-decision-hooks.md` |
| Roadmap scout | `.agents/overlays/<project>-stellar-spacemap.md` |
| Master pack map | `.agents/overlays/<project>-master-planner.md` |

**Tweak law (non-negotiable):**

1. **Orwell** — short words; cut dead metaphors; prefer active verbs; one idea per line.
2. **Action** — every section ends in a verb the agent can run (path, command, refuse).
3. **Diagram** — one mermaid or ASCII arch for the fused loop; drop second prose copy.
4. **Compress** — tables > paragraphs; drop legacy unless still live; no token waste.
5. **Specific** — real paths and verify commands for *this* cwd.

### 5. Ontology (large / complex only)

Create when **≥2** of: multi-crate/control-plane, agent-facing contracts, easy wrong-file edits, cross-module invariants.

Assets (template: [references/ontology-template.md](references/ontology-template.md)):

| File | Role |
|------|------|
| `.agents/ontology/INDEX.md` | Intent → subgraph router |
| `.agents/ontology/<project>.graph.yaml` | Nodes + edges + `source_refs` |
| `.agents/ontology/GRAPH.md` | Optional mermaid viz |

Point agents: load subgraph by intent; never dump full graph.

### 6. Wire AGENTS.md

Update **Active skills** table: skill · path · when. Point overlays. Keep verify block exact.

### 7. Verify

```bash
./scripts/verify-pack.sh --project "$(pwd)"
# then project checks from AGENTS.md (lint, tests, --validate, …)
```

**Done when:**

- [ ] Pack symlinks resolve
- [ ] Overlays match live architecture (no dead entrypoints)
- [ ] Ontology (if any) subgraphs route without contradiction
- [ ] AGENTS.md lists active skills + verify commands
- [ ] Report: pack · mission · friction removed · next automation

---

## Pack router

| Stack signals | Pack | Core skills |
|---------------|------|-------------|
| `install.sh` + profiles + maintenance + archy/TUI | **arch-guardian** | master-planner, eagle-*, ai-optimization, fusion-sage, HODA, stellar-spacemap, verification-cockpit, session-unit-order, agent-orchestrator, control-graph, git-worktrees |
| `~/.config/shell` / path.contract | **shell-verify** | shell-kernel-ontology, verification-cockpit, stellar-spacemap, ai-optimization, fusion-sage |
| Next.js / React app | **web-app** | ai-optimization, fusion-sage, react-client-expert, semantic-markup-css, fix-dependency-security |
| Tauri + agent loops | **agentic-desktop** | finder-reactor, tauri-agentic, agent-orchestrator, git-worktrees, control-graph |
| Multi-agent delivery only | **multi-agent** | agent-orchestrator, control-graph, git-worktrees, concurrent-cli-agents, split-to-prs |
| Strategy / backlog docs | **strategy** | HODA, stellar-spacemap, fusion-sage, master-planner |

Custom: compose from catalog; document in overlay.

---

## Master plan output (when user wants the plan, not only the pull)

```markdown
## Master plan — <project>

**Mission:** <one sentence — the impossible made routine>

**Friction web:**
| Automation | Removes | Skill / path | Verify |
|------------|---------|--------------|--------|

**Arch:**
\`\`\`mermaid
flowchart LR
  ...
\`\`\`

**Refuse / build:** …
**Next wave:** …
```

Pair roadmap depth with [stellar-spacemap](../stellar-spacemap/SKILL.md). Pair material bets with [higher-order-decision-architect](../higher-order-decision-architect/SKILL.md).

---

## Anti-patterns

| ¬ | Do |
|---|-----|
| prose roadmap, no automation edges | friction web table + skills |
| fork portable `SKILL.md` per project | overlays + symlink |
| pull whole library “just in case” | pack router |
| ontology = AGENTS.md copy | addressable IDs + subgraphs |
| dead shims as primary | update or delete overlays |
| funeral close | name acceleration automation |

**Refs:** [orwell-tweak](references/orwell-tweak.md) · [ontology-template](references/ontology-template.md) · [arch-machine-pack](examples/arch-machine-pack.md) · [master-planner.mdc](../rules/master-planner.mdc)

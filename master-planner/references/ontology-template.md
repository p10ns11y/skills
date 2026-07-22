# Ontology template (large / complex projects)

Use when agents re-derive architecture every turn. Addressable IDs beat prose.

## Layout

```text
.agents/ontology/
├── INDEX.md                 # intent → subgraph router
├── <project>.graph.yaml     # nodes + edges + source_refs
└── GRAPH.md                 # optional mermaid
```

## INDEX.md skeleton

```markdown
# <Project> ontology

**Graph:** [<project>.graph.yaml](<project>.graph.yaml) · **Viz:** [GRAPH.md](GRAPH.md)

## Subgraphs (load by intent)

| Intent | Start nodes | When |
|--------|-------------|------|
| control | proj:ControlPlane | Edit archy / TEA / job routing |
| install | proj:ProfileEngine | Profiles, modules, install.sh |
| evidence | proj:EvidenceLoop | Bundles, remediation |
| verify | proj:VerifyGate | make lint / validate / tests |

## Concept → files

| Concept | Files |
|---------|-------|
| … | … |
```

## Graph YAML skeleton

```yaml
meta:
  version: "1.0"
  project: <slug>
  last_updated: "YYYY-MM-DD"

nodes:
  - id: proj:ControlPlane
    type: Domain
    name: Control Plane
    subgraph: control
    fused_summary: >
      One sentence. No fluff.
    source_refs:
      - tools/archy/
      - docs/archy.md

edges:
  - from: proj:ControlPlane
    to: proj:EvidenceLoop
    rel: feeds
```

## Rules

- **IDs** stable (`proj:Name`); rename = breaking.
- **fused_summary** ≤ 2 sentences.
- **source_refs** must exist.
- Load **one subgraph** per task; never paste full graph into chat.
- Pair with [shell-kernel-ontology](../../shell-kernel-ontology/SKILL.md) patterns for drift gates if you add check scripts later.

# Example pack — arch-machine

**Mission:** Self-remediating Arch guardian — Eagle routes jobs; shells + evidence close the loop.

**Pack:** `arch-guardian`

| Skill | Kind | Role |
|-------|------|------|
| master-planner | symlink | Pull/tweak/ontology |
| eagle-satellite-elomaxz | in-repo | TEA control plane |
| session-unit-order | in-repo / publish | systemd + UWSM order |
| ai-optimization | symlink | Token budget |
| fusion-sage | symlink | Fused loop + surplus |
| higher-order-decision-architect | symlink | Material decisions |
| stellar-roadmap | symlink | SN-* backlog |
| verification-cockpit | symlink | `av` cockpit |
| agent-orchestrator | symlink | Multi-step delivery |
| looper | symlink | Budgeted agent loops |
| git-worktrees | symlink | Isolated workers |

**Overlays:** `.agents/overlays/arch-machine-*.md`  
**Ontology:** `.agents/ontology/` (control · install · evidence · verify)

**Verify:**

```bash
make lint
make validate-profiles
cargo test --manifest-path tools/archy/Cargo.toml
./install.sh --thin --validate
```

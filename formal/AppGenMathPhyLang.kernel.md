# AppGenMathPhyLang — library kernel

> **Experimental dense dialect** for control-plane and architecture skills.  
> Not a formal logic system — applied generative math–physics **notation** for agents.  
> Provenance: ensembly `formal_problem_definition.AppGenMathPhyLang.md` (pure block only).

## Load rule (progressive disclosure)

```text
1. Prefer formal SoT in SKILL.md
2. Where a symbol may confuse: inline English in (parentheses) or // comments
3. Full plain-English procedure lives in references/*.md
4. Agent expands English reference ONLY IF formal spec is insufficient for the current step
5. Never dual-load formal + full English by default (token waste)
```

## Shared signature

```text
S          : state / life-state / problem state
G = (V,E)  : directed dependency graph (tasks, files, steps)
CP(G)      : critical-path / prioritization operator on G
P          : uncertainty (PERT | MonteCarlo | confidence)
Runtime    : control plane (orchestrator host / outer graph)
Agents     : workers (Inner steps, subagents)
Human      : scarce high-value resource
HITL       : human-in-the-loop gate
HOOTL      : human-out-of-the-loop (auto only when safe)
Digital    : automatable domain
Physical ∪ HighRisk  : must Surface to human

// Evaluation triple (skill quality + decision quality)
∀δ ∈ Decisions ∪ SkillEdits :
  Evaluate(δ) ≔ (Correctness(δ), Effectiveness(δ), Efficiency(δ))
  // Correctness  = does the right thing
  // Effectiveness = saves energy & future effort
  // Efficiency   = spends less time & tokens/cost

Success(δ) ⇔ ΔCorrectness > 0 ∨ ΔEffectiveness > 0 ∨ ΔEfficiency > 0
```

## Control axioms (agent systems)

```text
Automate(Digital)
Surface(Physical ∪ HighRisk)
WaitOnlyForPermission(Human)     // loop waits only when necessary

Runtime ⊨ GlobalTruth ∧ Prioritization ∧ EscalationPolicy
Agents  ⊨ LocalDecision ∧ DigitalExec ∧ Report
Runtime ⊥ Agents  via typed briefs / handoffs / MsgBus-like contracts

// control-graph specialization
Outer ≔ state machine | cyclic loop on Phases
Inner ≔ DAG | nested bounded loop
Outer owns transitions; Inner never silently jumps to DONE
```

## Skill anatomy under this dialect

```text
SKILL.md          = formal SoT + tables + one diagram + anti-patterns
references/       = English expansion, templates, deep tables
scripts/          = verify (structural or runtime)
examples/         = project overlays (never fork skill bodies)

Line budget (target): SKILL.md ≲ 200 lines formal-first
                      depth → references/ progressive disclosure
```

## Diagram policy

```text
// See QUALITY.md § Diagram policy (canonical)
Default: table | compact ASCII
Mermaid: only if multi-lane/sequence/gantt OR dense topology where ASCII fails
         AND diagram is SoT (not a second copy of a table)
Never:   decorative · diagram + full prose of same edges
Prefer:  1 topology + decision tables  ≻  long narrative
```

## When NOT to use heavy formal dialect

- Pure UI/CSS/copy skills  
- One-shot mechanical checklists already clear in English  
- When the audience is human-only docs (use README English)  

Formal density pays for **control plane, prioritization, guards, multi-agent shape**.

## Source split from ensembly doc

| Part of original | Use here |
|------------------|----------|
| Pure formal §I | Kernel + skill headers |
| Professor read-aloud | **Do not** ship as agent context |
| Project-specific peram-kernel mapping | Keep in ensembly, not this library |

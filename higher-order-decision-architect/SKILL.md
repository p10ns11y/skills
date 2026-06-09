---
name: higher-order-decision-architect
description: >-
  Applies first-principles, multi-order consequence analysis, inversion, systems
  thinking, probability, and antifragility before material coding decisions
  (architecture, dependencies, public API, security, data contracts, hard-to-revert
  refactors). Use when choosing between approaches, planning cross-cutting changes,
  or when the user asks for decision analysis, tradeoffs, pre-mortem, or second-order
  effects.
---

# Higher-Order Decision Architect

Before **material coding decisions**, reason through this framework internally. You do **not** need the full output block in every reply — but for non-trivial decisions, surface **Executive Verdict**, **risks**, **confidence**, and **next actions**.

**Material decision** = architecture, dependencies, public API, security, data contracts, multi-module refactors, or anything hard to revert.

Optional project overlay: [examples/overlays/thepulimaangani-decision-hooks.md](../examples/overlays/thepulimaangani-decision-hooks.md).

---

## Mental models (exact sequence)

1. **First principles** — Constraints, invariants, maintenance economics, human factors. Do not default to “best practice” or analogy alone.
2. **Second- & higher-order thinking** — For each option: “And then what?” until the chain stabilizes. Map 1st-, 2nd-, 3rd-order+ effects.
3. **Inversion + pre-mortem** — “How could this fail at order 2 or 3?” Then: “12–24 months later this failed — what went wrong?”
4. **Systems thinking** — Stocks, flows, feedback loops, delays, leverage points.
5. **Probabilistic thinking** — Rough probabilities; Bayesian update when evidence arrives; avoid binary “will/won’t” when uncertain.
6. **Circle of competence + regret minimization** — Known vs guessed; which path minimizes regret for maintainers, users, agents?
7. **Antifragility** — Prefer options that **gain** from small volatility (tests, flags, contracts) vs brittle one-shot bets.

---

## Mandatory process

1. **Diagnose the critical zone** — Single highest-leverage / highest-uncertainty bottleneck. If unclear, ask 1–2 sharp questions.
2. **Deconstruct with first principles**
3. **Map consequence chain** (1st → 2nd → 3rd+) with rough probabilities
4. **Inversion & pre-mortem** on top 2–3 options
5. **Systems + antifragility**
6. **Synthesize** — One recommendation + explicit confidence + assumptions + **leading indicators** to watch

---

## Output format (non-trivial decisions)

**Executive Verdict** (1–2 sentences)

**Critical Area Identified** — One sentence

**First Principles Breakdown** — Bullets

**Consequence Chain** — Table: Order | Effect | Probability | Impact (H/M/L) | Notes

**Inversion & pre-mortem risks** — Top failure modes at order 2+ and mitigations

**Recommended Decision** — Clear action + 2–3 sentence rationale

**Confidence & uncertainties** — Confidence %; key assumptions; monitoring signals

**Immediate next actions** — Max 3 concrete steps

---

## Non-negotiable rules

- Be direct; say “unknown” or “outside reliable competence” when true.
- No corporate hedge-speak; prefer precise language.
- Prefer long-term (3rd-order+) value over short-term optics when they conflict.
- Weak evidence → state probability ranges.
- When closing a decision advisory turn, you may ask: “Stress-test further or apply to another project area?”

---

## Activation

- User asks for tradeoffs, architecture choice, “what could go wrong”, pre-mortem, or second-order effects.
- Agent is about to pick dependencies, public API shape, security model, or a cross-module refactor.
- Pair with domain skills ([bdd-strategizer](../bdd-strategizer/SKILL.md) for test-first decomposition; [fusion-sage](../fusion-sage/SKILL.md) for long-term surplus).

## Cursor rule (optional)

Symlink [rules/higher-order-decision-architect.mdc](../rules/higher-order-decision-architect.mdc) into `.cursor/rules/` with `alwaysApply: true` to route material decisions to this skill without pasting the full framework every turn.

**Example provenance:** [Thepulimaangani](https://github.com/p10ns11y/thepulimaangani) (Tamil prosody / WASM parser decisions).

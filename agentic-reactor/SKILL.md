---
name: agentic-reactor
description: Overarching patterns for self-guarded, pause-aware, agent-driven desktop/web platforms. Combines finder-reactor, Tauri shell, X resources, and CV guard into a cohesive autonomous system with intervention only on guards. Use for high-level autonomy design, meta-improvement loops, MCP composability. Fusion for the reactor as living system; fission for specific guards.
---

# Agentic Reactor — The Living, Self-Improving Finder Platform

**Core Mission**: Make an opportunity-finder not just a tool, but an autonomous agent that runs with minimal human input, using self-guards and pauses to stay safe. It decides, acts (search, prep), learns, and improves — surfacing only when necessary (low fit, high cost, CV changes).

## Principles

- **Autonomy with Guardrails**: Reactor loop runs search → analyze → decide → prep if cleared → track.
- **Pauses**: Explicit intervention points via UI dialogs and MCP pause responses.
- **Smart Decisions**: Structured "next action" with guards evaluated in the core (Rust or backend service).
- **Self-Improvement**: After cycles, surplus proposals — auto-apply low-risk, pause for high-impact.
- **Composability**: Full MCP exposure so Cursor, Grok, or other agents can invoke guarded hunts.
- **Integration**: X via [x-agent-resources](../x-agent-resources/SKILL.md); CV via [cv-promote-guard](../cv-promote-guard/SKILL.md); shell via [tauri-agentic](../tauri-agentic/SKILL.md).

## Architecture (Fusion View)

**FinderReactor (core)**:
- State: leads/preps in app data (JSON or SQLite).
- Guards: Cost, Rate, Fit, CVPromote (delegates to cv-promote-guard).
- X layer: x-agent-resources patterns.
- MCP server: reactor methods + `ask_user` for pauses.
- Optional background daemon with tray/UI surfacing pauses.

**Shell (Tauri or web)**:
- Command palette + guard dashboards + pause modals.
- Frontend: [react-client-expert](../react-client-expert/SKILL.md) minimal state.

## Surplus Protocol

After reactor-related work, document Q-factor wins and suggested follow-ups. Track in surplus-log or fusion-state.

## Activation

High-level design: load agentic-reactor + finder-reactor + tauri-agentic + fusion-sage.

**Example provenance:** [collab-finder](../examples/README.md).

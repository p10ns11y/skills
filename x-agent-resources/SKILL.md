---
name: x-agent-resources
description: Integration and usage of official X Developer Platform agent resources (llms.txt, skill.md, MCP/XMCP, xurl, OpenAPI) for accurate, composable X access in agentic apps. Use when building search, analysis, posting, or any X interaction. Ensures llms/skill ground prompts, MCP exposes tools, xurl provides CLI UX. Fission for implementation; fusion for unifying with finder-reactor and agentic design.
---

# X Agent Resources — Official Primitives for X-Powered Agents

**Core Mission**: Make every X interaction correct, efficient, and agent-composable by treating official X agent resources as first-class citizens.

## Key Resources (Always Reference Fresh or Cached)

- **llms.txt / llms-full.txt** (https://docs.x.com/llms.txt): Structured index + full Markdown docs for LLMs.
- **skill.md** (https://docs.x.com/skill.md): agentskills.io spec — capabilities, actions, params, constraints, workflows.
- **MCP Servers**: [XMCP](https://github.com/xdevplatform/xmcp) (200+ endpoints as tools); [Docs MCP](https://docs.x.com/mcp).
- **xurl** (https://github.com/xdevplatform/xurl): Official CLI with auto-auth and agent SKILL.md.
- **OpenAPI**: https://api.x.com/2/openapi.json

## Agent read order (mandatory for X work)

1. Vendored snapshot in your project (e.g. `.agents/x-resources/skill.md`) — **read first**.
2. This skill — integration patterns for your app.
3. Live `https://docs.x.com/...` if behavior disagrees with snapshot — refresh vendored copy.

## Integration Principles

1. **Ingest for Intelligence**: LLM calls include relevant excerpts from X skill.md + llms context.
2. **MCP for Composability**: Expose app functions (search, analyze, prep, promote) as MCP tools; use XMCP for direct X ops when richer than a custom client.
3. **xurl for UX & Fallback**: Shell to xurl for ad-hoc or as reference implementation.
4. **Follow the Spec**: Publish your own SKILL.md compatible with agentskills.io.
5. **Self-Guards Apply**: MCP tool calls respect the same guards/pauses as the UI.

## Implementation Patterns

- **At startup / refresh**: Load vendored X resources; copy to app data in production if needed.
- **Backend client**: Validate/build queries using skill.md knowledge; prefix prompts with current capabilities excerpt.
- **MCP Server**: Tools like `search_x_opportunities`, `analyze_and_decide`, `generate_prep_with_guards`, `promote_with_preview`.
- **UI**: Command palette maps 1:1 to MCP tools.
- **Prompt library**: Central file combining X skill + CV packet + app state.
- **Testing**: [bdd-strategizer](../bdd-strategizer/SKILL.md) for guard scenarios (429, low rate, pause).

## Guardrails

- Never assume X API behavior not in current skill.md/llms.
- Writes (posts, DMs): always guard + user pause.
- Rate limits: surface from headers; backoff in reactor.
- Auth: secure OS keyring or encrypted store — never hardcode tokens.

## Related

[finder-reactor](../finder-reactor/SKILL.md), [tauri-agentic](../tauri-agentic/SKILL.md), [ai-optimization](../ai-optimization/SKILL.md), [fusion-sage](../fusion-sage/SKILL.md).

Official: https://docs.x.com/tools/ai

**Example provenance:** [collab-finder](https://github.com/p10ns11y/collab-finder).

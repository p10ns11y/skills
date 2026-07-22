# Orwell tweak law — skill overlays

Apply when writing or refreshing project overlays. Goal: **almost no wasted tokens**, still actionable.

## Six rules (Orwell → agent skills)

| Orwell | Overlay rule |
|--------|----------------|
| Never use a metaphor you are used to seeing in print | Drop “journey”, “leverage synergies”, “ecosystem” unless it names a real module |
| Never use a long word where a short one will do | Prefer *run*, *wire*, *cut*, *refuse* over *utilize*, *orchestrate* (unless TEA/Eagle proper nouns) |
| If it is possible to cut a word out, cut it out | One idea per line; delete throat-clearing |
| Never use the passive where you can use the active | “Agent runs `make lint`” not “linting should be performed” |
| Never use a foreign phrase, scientific word, or jargon if everyday English will do | Keep domain terms that are **contracts** (`install_*`, Msg, Cmd); drop filler jargon |
| Break any of these sooner than say anything outright barbarous | Clarity > purity |

## Action orientation

Every block must answer **do what, where, when fail**:

| Bad | Good |
|-----|------|
| “Consider the TUI carefully” | Edit `tools/archy/`; load eagle skill; verify `cargo test --manifest-path tools/archy/Cargo.toml` |
| “Evidence is important” | Never strip `policies/security-remediation.md`; dry-run before apply |

## Diagram budget

- **One** fused loop (ASCII or mermaid) per overlay.
- No second prose paragraph restating the diagram.
- Node IDs: camelCase, no spaces.

## Compression budget

| Keep | Drop |
|------|------|
| Live entrypoints + verify commands | Legacy paths unless still shipped |
| Never-compress list | Motivational essays |
| Relevance boost table | Full file dumps |
| Refuse vs build (2 columns) | Hedge walls |

Target: overlay **≤ ~50 lines** unless ontology-adjacent.

## Verify after tweak

1. Paths exist (`test -e`).
2. Primary surface matches AGENTS.md fused abstraction.
3. No skill-body edits — overlay only.

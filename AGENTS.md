# AGENTS.md — skills library

**Owner:** Steward / Fleet coordination for this skill library — keep skills portable, composable, and canonical here.

**Canonical remote:** https://github.com/p10ns11y/skills

## Scope

- Edit skills, rules, workflows, and library docs in this repo only.
- Skill bodies are formal-first SoT (`SKILL.md`); depth in `references/` or `examples/`.
- Slash/plugin harnesses live in [p10ns11y/plugins](https://github.com/p10ns11y/plugins) — link, do not vendor.

## Verification

```bash
# Per-skill validators where present (example)
node control-graph/scripts/validate-skill.mjs
node odysseus-navigator/scripts/validate-skill.mjs
```

Meet [QUALITY.md](QUALITY.md) before merge. Catalog and packs: [README.md](README.md).

## Hard nos

- **No secrets / PII** — never commit credentials, tokens, private keys, or personal data.
- **No thecuriousts CI burn** — do not wire CI, dispatch workflows, or push changes that trigger builds in `thecuriousts/*` repos from here.
- **No Reset** — no `git reset --hard`, force-push to shared branches, or context/session resets that discard in-flight work without explicit human approval.
- **Don't delete SoT elsewhere** — this tree owns skill SoT; do not remove canonical copies in sibling repos (e.g. plugins harness, project overlays) — update or link instead.

## PR hygiene

Name the harness and tools used. Use [.github/pull_request_template.md](.github/pull_request_template.md).

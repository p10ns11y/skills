# Plugin (other repo)

Slash harness **does not live here.** Skill SoT is this directory (`SKILL.md`).

| Layer | Repo |
|-------|------|
| Skill | [p10ns11y/skills odysseus-navigator](https://github.com/p10ns11y/skills/tree/master/odysseus-navigator) |
| Plugin | [p10ns11y/plugins odysseus-navigator](https://github.com/p10ns11y/plugins/tree/main/odysseus-navigator) |

```bash
grok plugin install odysseus-navigator --trust
# sibling checkout:
ln -sfn "$HOME/Work/personal/skills/odysseus-navigator" \
  "$HOME/Work/personal/plugins/odysseus-navigator/skills/odysseus-navigator"
```

`/odysseus-core` — one bottleneck, at most one mistake, one next.  
`/odysseus` — full Navigator.  
No C tether, no Rhai, no prior forks (EVA owns those).

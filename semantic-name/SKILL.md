---
name: semantic-name
description: >-
  Name the thing for what it does in that context. Do not use Gate as a
  default label. Triggers: "Never over use the word Gate, use semantically
  meaniful name for the context and situation"; "why all the llms are now
  using 'gate' word too much. rename it to something semantic and meaniful".
user-invocable: true
---

# semantic-name

Name the thing for what it does in that context. Do not use Gate as a default label.

## When / skip

| Use | Skip |
|-----|------|
| naming a module, flag, route, type, or function | the user asked for the word Gate |
| an existing name uses Gate as a default label | a domain word that already states the job |

## Procedure

1. When you name a module, flag, route, type, or function, use a word that states the job in this context.
2. Do not use Gate as a default label. Do not invent Gate compounds unless the user asks for that word.
3. If a name already uses Gate, rename it to a semantic name and update the call sites in the same change.

## Done when

- [ ] The name states the job in this context
- [ ] Call sites match the new name in the same change
- [ ] A search of the change shows no leftover Gate label for that thing

## Anti-patterns

| ¬ | Do |
|---|-----|
| Gate as a default label | a word that states the job |
| rename the declaration only | update call sites in the same change |
| invent a Gate compound | keep Gate only when the user asked for that word |

---
name: plan-to-sentinel-wave-prioritization
description: convert raw plan docs into neutral wave files with sentinel prompts, regression buckets, and progress lock for autonomous execution
kind: workflow
skill_chain: ["scan-and-extract-plans", "neutral-wave-filenames", "sentinel-coordination-pack"]
---

# plan-to-sentinel-wave-prioritization

convert raw plan docs into neutral wave files with sentinel prompts, regression buckets, and progress lock for autonomous execution

## Skill chain

1. `scan-and-extract-plans`
2. `neutral-wave-filenames`
3. `sentinel-coordination-pack`

## Phases

### Explore

Glob and read all .kilo/plans/*.md

### Prioritize

map P1-P4 status and correct sentinel assignments

### Artifact

create .composer/waves with neutral names and regression table

### Coordinate

add ordered prompts + progress.md lock

## Support

- sessions: 1
- rank: 29

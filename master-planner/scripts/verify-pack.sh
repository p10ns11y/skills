#!/usr/bin/env bash
# Verify skill pack wiring for a project.
set -euo pipefail

PROJECT=""
TARGET_SUBDIR=".agents/skills"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="${2:?}"; shift 2 ;;
    --target-subdir) TARGET_SUBDIR="${2:?}"; shift 2 ;;
    -h|--help)
      echo "Usage: verify-pack.sh --project DIR"
      exit 0
      ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

[[ -n "$PROJECT" && -d "$PROJECT" ]] || { echo "--project DIR required" >&2; exit 2; }

dest="$PROJECT/$TARGET_SUBDIR"
fail=0

echo "== skills in $dest =="
if [[ ! -d "$dest" ]]; then
  echo "FAIL: missing $dest"
  exit 1
fi

shopt -s nullglob
for entry in "$dest"/*; do
  name="$(basename "$entry")"
  if [[ -L "$entry" ]]; then
    if [[ -d "$entry" ]]; then
      echo "OK   symlink $name → $(readlink "$entry")"
    else
      echo "FAIL broken symlink $name → $(readlink "$entry")"
      fail=$((fail + 1))
    fi
  elif [[ -d "$entry" ]]; then
    if [[ -f "$entry/SKILL.md" ]]; then
      echo "OK   in-repo $name"
    else
      echo "FAIL in-repo $name missing SKILL.md"
      fail=$((fail + 1))
    fi
  fi
done

echo "== overlays =="
if [[ -d "$PROJECT/.agents/overlays" ]]; then
  for f in "$PROJECT/.agents/overlays"/*.md; do
    [[ -f "$f" ]] || continue
    lines="$(wc -l <"$f" | tr -d ' ')"
    if [[ "$lines" -gt 80 ]]; then
      echo "WARN overlay fat ($lines lines): $f"
    else
      echo "OK   overlay $(basename "$f") ($lines lines)"
    fi
  done
else
  echo "NOTE no .agents/overlays/"
fi

echo "== ontology =="
if [[ -d "$PROJECT/.agents/ontology" ]]; then
  for need in INDEX.md; do
    if [[ -f "$PROJECT/.agents/ontology/$need" ]]; then
      echo "OK   ontology/$need"
    else
      echo "FAIL ontology missing $need"
      fail=$((fail + 1))
    fi
  done
  graphs=("$PROJECT"/.agents/ontology/*.graph.yaml)
  if [[ -e "${graphs[0]:-}" ]]; then
    echo "OK   graph yaml present"
  else
    echo "WARN ontology dir without *.graph.yaml"
  fi
else
  echo "NOTE no ontology (ok if project not complex)"
fi

echo "== AGENTS.md =="
if [[ -f "$PROJECT/AGENTS.md" ]]; then
  if grep -qiE 'skill|verify' "$PROJECT/AGENTS.md"; then
    echo "OK   AGENTS.md mentions skills/verify"
  else
    echo "WARN AGENTS.md lacks skill/verify cues"
  fi
else
  echo "WARN no AGENTS.md"
fi

echo "---"
if [[ "$fail" -eq 0 ]]; then
  echo "verify-pack: PASS"
else
  echo "verify-pack: FAIL ($fail)"
  exit 1
fi

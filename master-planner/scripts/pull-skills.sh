#!/usr/bin/env bash
# Pull skill pack into a project (symlinks). Never copies skill bodies.
# Resolves library via resolve-skills-root.sh (local → https://github.com/p10ns11y/skills).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT=""
PACK=""
SKILLS_CSV=""
TARGET_SUBDIR=".agents/skills"
FROM_REMOTE=0
RESOLVE_ARGS=()

usage() {
  cat <<'EOF'
Usage:
  pull-skills.sh --project DIR --pack PACK_NAME
  pull-skills.sh --project DIR --skills a,b,c
  pull-skills.sh --project DIR --pack PACK_NAME --from-remote

Packs: arch-guardian | shell-verify | web-app | agentic-desktop | multi-agent | strategy
Env:   SKILLS_ROOT (optional override)
       SKILLS_REMOTE (default: https://github.com/p10ns11y/skills.git)
       SKILLS_CACHE  (default: ~/.cache/p10ns11y-skills)
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="${2:?}"; shift 2 ;;
    --pack) PACK="${2:?}"; shift 2 ;;
    --skills) SKILLS_CSV="${2:?}"; shift 2 ;;
    --target-subdir) TARGET_SUBDIR="${2:?}"; shift 2 ;;
    --from-remote) FROM_REMOTE=1; RESOLVE_ARGS+=(--from-remote); shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

[[ -n "$PROJECT" ]] || { echo "--project required" >&2; exit 2; }
[[ -d "$PROJECT" ]] || { echo "Not a directory: $PROJECT" >&2; exit 2; }

SKILLS_ROOT="$("$SCRIPT_DIR/resolve-skills-root.sh" "${RESOLVE_ARGS[@]+"${RESOLVE_ARGS[@]}"}")"
echo "SKILLS_ROOT=$SKILLS_ROOT"
[[ -d "$SKILLS_ROOT" ]] || { echo "SKILLS_ROOT missing: $SKILLS_ROOT" >&2; exit 2; }

declare -A PACKS=(
  [arch-guardian]="master-planner ai-optimization fusion-sage higher-order-decision-architect stellar-roadmap verification-cockpit agent-orchestrator control-graph git-worktrees"
  [shell-verify]="master-planner shell-kernel-ontology verification-cockpit stellar-roadmap ai-optimization fusion-sage higher-order-decision-architect"
  [web-app]="master-planner ai-optimization fusion-sage react-client-expert semantic-markup-css fix-dependency-security higher-order-decision-architect"
  [agentic-desktop]="master-planner finder-reactor tauri-agentic agent-orchestrator git-worktrees control-graph fusion-sage"
  [multi-agent]="master-planner agent-orchestrator control-graph git-worktrees concurrent-cli-agents split-to-prs"
  [strategy]="master-planner higher-order-decision-architect stellar-roadmap fusion-sage ai-optimization"
)

skills=()
if [[ -n "$SKILLS_CSV" ]]; then
  IFS=',' read -r -a skills <<< "$SKILLS_CSV"
elif [[ -n "$PACK" ]]; then
  [[ -n "${PACKS[$PACK]:-}" ]] || { echo "Unknown pack: $PACK" >&2; exit 2; }
  # shellcheck disable=SC2206
  skills=(${PACKS[$PACK]})
else
  echo "Need --pack or --skills" >&2
  exit 2
fi

dest="$PROJECT/$TARGET_SUBDIR"
mkdir -p "$dest"

pulled=0
skipped=0
missing=0
for name in "${skills[@]}"; do
  name="${name// /}"
  [[ -n "$name" ]] || continue
  src="$SKILLS_ROOT/$name"
  if [[ ! -d "$src" ]]; then
    echo "MISSING library skill: $name ($src)" >&2
    missing=$((missing + 1))
    continue
  fi
  link="$dest/$name"
  if [[ -e "$link" || -L "$link" ]]; then
    if [[ -L "$link" ]]; then
      cur="$(readlink -f "$link" 2>/dev/null || readlink "$link")"
      want="$(readlink -f "$src")"
      if [[ "$cur" == "$want" ]]; then
        echo "OK   $name (already linked)"
        skipped=$((skipped + 1))
        continue
      fi
      ln -sfn "$src" "$link"
      echo "RELINK $name → $src"
      pulled=$((pulled + 1))
    else
      echo "KEEP $name (in-repo directory, not overwritten)"
      skipped=$((skipped + 1))
    fi
  else
    ln -sfn "$src" "$link"
    echo "LINK $name → $src"
    pulled=$((pulled + 1))
  fi
done

echo "---"
echo "pulled/relinked=$pulled kept/ok=$skipped missing=$missing dest=$dest from_remote=$FROM_REMOTE"
[[ "$missing" -eq 0 ]]

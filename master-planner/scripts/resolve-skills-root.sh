#!/usr/bin/env bash
# Resolve skills library root: env → local checkout → clone remote.
set -euo pipefail

SKILLS_REMOTE="${SKILLS_REMOTE:-https://github.com/p10ns11y/skills.git}"
SKILLS_CACHE="${SKILLS_CACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/p10ns11y-skills}"
FROM_REMOTE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --from-remote) FROM_REMOTE=1; shift ;;
    --cache) SKILLS_CACHE="${2:?}"; shift 2 ;;
    --remote) SKILLS_REMOTE="${2:?}"; shift 2 ;;
    -h|--help)
      cat <<'EOF'
Usage: resolve-skills-root.sh [--from-remote] [--cache DIR] [--remote URL]

Order (unless --from-remote):
  1. $SKILLS_ROOT if it exists
  2. ~/Work/personal/skills if it exists
  3. Clone/update https://github.com/p10ns11y/skills into cache
EOF
      exit 0
      ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

clone_or_update() {
  local dest="$1"
  if [[ -d "$dest/.git" ]]; then
    git -C "$dest" fetch --quiet origin
    # prefer origin/master (skills default); fall back to HEAD
    if git -C "$dest" rev-parse --verify -q origin/master >/dev/null; then
      git -C "$dest" checkout -q master 2>/dev/null || git -C "$dest" checkout -q -B master origin/master
      git -C "$dest" merge --ff-only -q origin/master || git -C "$dest" reset --hard -q origin/master
    else
      git -C "$dest" pull --ff-only -q || true
    fi
    printf '%s\n' "$dest"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  git clone --depth 1 "$SKILLS_REMOTE" "$dest" >/dev/null
  printf '%s\n' "$dest"
}

if [[ "$FROM_REMOTE" -eq 1 ]]; then
  clone_or_update "$SKILLS_CACHE"
  exit 0
fi

if [[ -n "${SKILLS_ROOT:-}" && -d "${SKILLS_ROOT}" ]]; then
  printf '%s\n' "$SKILLS_ROOT"
  exit 0
fi

if [[ -d "$HOME/Work/personal/skills" ]]; then
  printf '%s\n' "$HOME/Work/personal/skills"
  exit 0
fi

# Local missing → remote
clone_or_update "$SKILLS_CACHE"

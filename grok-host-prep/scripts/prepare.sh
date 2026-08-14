#!/usr/bin/env bash
# grok-host-prep: check (default) or apply host knobs for Grok Build.
# Never prints MCP env values. Never rewrites existing [mcp_servers.*] tables.
set -euo pipefail

GROK_DIR="${GROK_HOME:-$HOME/.grok}"
CONFIG="$GROK_DIR/config.toml"
LSP_JSON="$GROK_DIR/lsp.json"
MODE="check"
INSTALL=0

usage() {
  cat <<'EOF'
Usage: prepare.sh [--check|--apply] [--install]

  --check    report only (default)
  --apply    write missing ~/.grok/lsp.json servers + append missing [features]
  --install  also install optional LSPs that are missing (npm -g typescript-language-server)

Does not: lower output_byte_limit, touch MCP secrets, enable always-approve,
          nest grok, or overwrite an existing lsp.json server name.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check) MODE=check ;;
    --apply) MODE=apply ;;
    --install) INSTALL=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown arg: $1" >&2; usage; exit 2 ;;
  esac
  shift
done

have() { command -v "$1" >/dev/null 2>&1; }

ok()   { printf 'OK    %s\n' "$1"; }
warn() { printf 'WARN  %s\n' "$1"; }
miss() { printf 'MISS  %s\n' "$1"; }

echo "== Grok Build host prep ($MODE) =="
echo "GROK_DIR=$GROK_DIR"
echo

echo "-- binaries --"
if have grok; then
  grok_path="$(command -v grok)"
  ok "grok -> $grok_path"
  if [[ "$grok_path" != "$GROK_DIR/bin/grok" ]] && [[ -x "$GROK_DIR/bin/grok" ]]; then
    warn "official binary is $GROK_DIR/bin/grok — PATH grok is a different path"
  fi
else
  miss "grok not on PATH (want $GROK_DIR/bin/grok)"
fi
if [[ -e "$HOME/.local/bin/grok" ]] && [[ "$(command -v grok 2>/dev/null || true)" != "$GROK_DIR/bin/grok" ]]; then
  warn "$HOME/.local/bin/grok exists — leftover shim can steal official grok"
fi
for c in rg git rustc cargo rust-analyzer clangd node npx python3; do
  if have "$c"; then ok "$c -> $(command -v "$c")"; else miss "$c"; fi
done
for c in typescript-language-server gopls pyright pylsp; do
  if have "$c"; then ok "$c -> $(command -v "$c")"; else warn "$c not installed (optional)"; fi
done

echo
echo "-- env / equivalent config --"
if [[ -n "${GROK_HOME-}" ]]; then ok "GROK_HOME=$GROK_HOME"; else ok "GROK_HOME unset (default ~/.grok)"; fi
if [[ "${GROK_LSP_TOOLS-}" == 1 ]] || grep -q '^lsp_tools *= *true' "$CONFIG" 2>/dev/null; then
  ok "lsp tool on (GROK_LSP_TOOLS or [features] lsp_tools)"
else
  warn "lsp tool off — set [features] lsp_tools = true or GROK_LSP_TOOLS=1"
fi
if [[ "${GROK_WEB_FETCH-}" == 1 ]]; then ok "GROK_WEB_FETCH=1"; else warn "GROK_WEB_FETCH unset — web_fetch stays hidden (env only)"; fi
if [[ "${GROK_MEMORY-}" == 1 ]]; then
  ok "GROK_MEMORY=1"
else
  warn "GROK_MEMORY unset — memory_search needs GROK_MEMORY=1 even if [memory] enabled"
fi
if [[ "${GROK_SUBAGENTS-}" == 1 ]] || grep -q '^\[subagents\]' "$CONFIG" 2>/dev/null; then
  ok "subagents on (GROK_SUBAGENTS or [subagents])"
else
  warn "subagents off — set [subagents] enabled = true or GROK_SUBAGENTS=1"
fi
[[ "${GROK_WEB_FETCH_ALLOW_LOCAL-}" == 1 ]] && warn "GROK_WEB_FETCH_ALLOW_LOCAL=1 (loopback only; leave off unless needed)"

echo
echo "-- files --"
[[ -f "$CONFIG" ]] && ok "config.toml" || miss "config.toml"
[[ -f "$LSP_JSON" ]] && ok "lsp.json" || miss "lsp.json (passive diagnostics + lsp tool need this)"

echo
echo "-- config.toml keys (names only) --"
if [[ -f "$CONFIG" ]]; then
  if grep -q '^\[features\]' "$CONFIG"; then ok "[features] present"; else miss "[features] (lsp_tools default false)"; fi
  if grep -q '^lsp_tools' "$CONFIG"; then
    if grep -q '^lsp_tools *= *true' "$CONFIG"; then ok "lsp_tools = true"; else warn "lsp_tools not true — lsp tool hidden"; fi
  else
    warn "lsp_tools unset (default false)"
  fi
  if grep -q '^codebase_indexing' "$CONFIG"; then
    grep -E '^codebase_indexing' "$CONFIG" | sed 's/^/OK    /'
  else
    ok "codebase_indexing unset (default true)"
  fi
  if grep -q '^\[memory\]' "$CONFIG"; then ok "[memory] present"; else warn "[memory] absent"; fi
  if grep -q '^\[session\]' "$CONFIG"; then ok "[session] present"; else ok "[session] absent (defaults: compact 85, load_envrc true)"; fi
  if grep -q '^\[subagents\]' "$CONFIG"; then ok "[subagents] present"; else warn "[subagents] absent (task tool off unless GROK_SUBAGENTS=1)"; fi
  if grep -q '^output_byte_limit' "$CONFIG"; then
    warn "output_byte_limit overridden — keep ≥ 8192"
  else
    ok "output_byte_limit unset (default 8192)"
  fi
  if grep -q 'permission_mode *= *"always-approve"' "$CONFIG"; then
    warn "permission_mode=always-approve — EVA forbids this; do not treat as a prep win"
  fi
  echo "MCP command checks (never dump env):"
  awk '
    $0 ~ /^\[mcp_servers\.[^].]+\]$/ && $0 !~ /\.env\]/ { name=$0; next }
    name != "" && $1 == "command" {
      gsub(/[" ]/, "", $3)
      print name, $3
      name=""
    }
  ' "$CONFIG" | while read -r sect cmd; do
    cmd="${cmd%%$'\r'}"
    if have "$cmd"; then ok "MCP ${sect} command=$cmd"; else miss "MCP ${sect} command=$cmd not on PATH"; fi
  done
else
  miss "cannot inspect config"
fi

echo
echo "-- recommended host tweaks --"
echo "1. lsp.json for every installed language server (user ~/.grok/lsp.json)"
echo "2. [features] lsp_tools = true  (or GROK_LSP_TOOLS=1)"
echo "3. leave codebase_indexing true"
echo "4. GROK_WEB_FETCH=1 if you want the web_fetch tool"
echo "5. GROK_SUBAGENTS=1 or --subagents for the task tool"
echo "6. [memory] enabled already works with GROK_MEMORY=1 / --experimental-memory"
echo "7. do not lower [toolset.bash] output_byte_limit below 8192"
echo "8. MCP: only add servers whose command exists; project .grok/config.toml replaces a name entirely"

apply_lsp_json() {
  local tmp
  tmp="$(mktemp)"
  python3 - "$LSP_JSON" "$tmp" <<'PY'
import json, shutil, sys
from pathlib import Path
dest = Path(sys.argv[1])
tmp = Path(sys.argv[2])
existing = {}
if dest.exists():
    existing = json.loads(dest.read_text())
    if not isinstance(existing, dict):
        raise SystemExit("lsp.json is not an object")

def which(name):
    from shutil import which
    return which(name)

wanted = {}
if which("rust-analyzer"):
    wanted["rust"] = {
        "command": "rust-analyzer",
        "args": [],
        "extensionToLanguage": {".rs": "rust"},
        "startupTimeout": 30000,
    }
if which("clangd"):
    wanted["c"] = {
        "command": "clangd",
        "args": ["--background-index"],
        "extensionToLanguage": {
            ".c": "c", ".h": "c", ".cpp": "cpp", ".cc": "cpp", ".hpp": "cpp",
        },
        "startupTimeout": 30000,
    }
if which("typescript-language-server"):
    wanted["typescript"] = {
        "command": "typescript-language-server",
        "args": ["--stdio"],
        "extensionToLanguage": {
            ".ts": "typescript", ".tsx": "typescriptreact",
            ".js": "javascript", ".jsx": "javascriptreact",
        },
        "startupTimeout": 30000,
    }
if which("gopls"):
    wanted["go"] = {
        "command": "gopls",
        "args": [],
        "extensionToLanguage": {".go": "go"},
        "startupTimeout": 30000,
    }
if which("pyright") or which("pyright-langserver"):
    cmd = "pyright-langserver" if which("pyright-langserver") else "pyright"
    wanted["python"] = {
        "command": cmd,
        "args": ["--stdio"],
        "extensionToLanguage": {".py": "python"},
        "startupTimeout": 30000,
    }

added = []
for name, spec in wanted.items():
    if name in existing:
        continue
    existing[name] = spec
    added.append(name)
tmp.write_text(json.dumps(existing, indent=2) + "\n")
print("lsp.json add:", ", ".join(added) if added else "(no new servers)")
PY
  mkdir -p "$GROK_DIR"
  mv "$tmp" "$LSP_JSON"
  ok "wrote $LSP_JSON"
}

apply_features() {
  if grep -q '^\[features\]' "$CONFIG" 2>/dev/null; then
    if grep -q '^lsp_tools *= *true' "$CONFIG"; then
      ok "[features] lsp_tools already true"
      return
    fi
    if grep -q '^lsp_tools' "$CONFIG"; then
      warn "lsp_tools already set — not rewriting; set true by hand"
      return
    fi
    # insert under [features]
    python3 - "$CONFIG" <<'PY'
from pathlib import Path
import sys
p = Path(sys.argv[1])
text = p.read_text()
needle = "[features]\n"
i = text.find(needle)
if i < 0:
    raise SystemExit("no [features]")
insert_at = i + len(needle)
p.write_text(text[:insert_at] + "lsp_tools = true\ncodebase_indexing = true\n" + text[insert_at:])
print("inserted lsp_tools under [features]")
PY
    ok "inserted lsp_tools under existing [features]"
    return
  fi
  printf '\n# appended by grok-host-prep\n[features]\nlsp_tools = true\ncodebase_indexing = true\n' >> "$CONFIG"
  ok "appended [features] lsp_tools = true"
}

if [[ "$INSTALL" -eq 1 ]]; then
  echo
  echo "-- install optional --"
  if have typescript-language-server; then
    ok "typescript-language-server already present"
  elif have npm; then
    npm install -g typescript-language-server typescript
    ok "installed typescript-language-server"
  else
    miss "npm missing; cannot install typescript-language-server"
  fi
fi

if [[ "$MODE" == apply ]]; then
  echo
  echo "-- apply --"
  apply_lsp_json
  if [[ -f "$CONFIG" ]]; then
    apply_features
    if grep -q '^\[subagents\]' "$CONFIG"; then
      ok "[subagents] already present"
    else
      printf '\n[subagents]\nenabled = true\n' >> "$CONFIG"
      ok "appended [subagents] enabled = true"
    fi
  else
    miss "no config.toml to append"
  fi
  echo
  echo "Restart grok (or new session) so lsp_tools + lsp.json load."
  echo "Still env-only: GROK_WEB_FETCH=1 GROK_MEMORY=1"
fi

#!/usr/bin/env bash
# Generic dev layout for herdr — nvim (80%) + shell (20%).
# Ports sesh/scripts/dev.sh to the herdr CLI.
#
# Usage: dev.sh <session_name> [project_dir]

set -euo pipefail

SESSION="${1:?session name required}"
DIR="${2:-$(pwd)}"

command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

existing=$(herdr workspace list \
  | jq -r --arg label "$SESSION" '.result.workspaces[] | select(.label == $label) | .workspace_id' \
  | head -1)
if [ -n "$existing" ]; then
  herdr workspace focus "$existing" >/dev/null
  exit 0
fi

_json() { jq -r "$1"; }

create=$(herdr workspace create --cwd "$DIR" --label "$SESSION" --focus)
p_nvim=$(printf '%s' "$create" | _json '.result.root_pane.pane_id')

# --ratio is the LEFT pane's share. Left = nvim → 0.8 keeps nvim at 80%.
herdr pane split "$p_nvim" --direction right --ratio 0.8 --cwd "$DIR" --no-focus >/dev/null
herdr pane focus --pane "$p_nvim" >/dev/null 2>&1 || true
herdr pane run "$p_nvim" nvim . >/dev/null

#!/usr/bin/env bash
# Monitor layout for herdr — k9s + btop in the left column (75%),
# 4 stacked shell panes in the right column (25%).
#
# Ports sesh/scripts/monitor.sh to the herdr CLI.
#
# Usage: monitor.sh [session_name] [project_dir]

set -euo pipefail

SESSION="${1:-monitor}"
DIR="${2:-$HOME/Development/ef}"

command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

existing=$(herdr workspace list \
  | jq -r --arg label "$SESSION" '.result.workspaces[] | select(.label == $label) | .workspace_id' \
  | head -1)
if [ -n "$existing" ]; then
  herdr workspace focus "$existing" >/dev/null
  exit 0
fi

_json() { jq -r "$1"; }

# ── Workspace + first pane (top-left, hosts k9s)
create=$(herdr workspace create --cwd "$DIR" --label "$SESSION" --focus)
ws=$(printf '%s' "$create" | _json '.result.workspace.workspace_id')
p_k9s=$(printf '%s' "$create" | _json '.result.root_pane.pane_id')

herdr tab rename "${ws}:t1" "monitor" >/dev/null 2>&1 || true

# --ratio is the LEFT/TOP pane's share.
# ── Right column (25% width) — will get 4 stacked shells. Left (k9s column) = 0.75.
p_right_top=$(herdr pane split "$p_k9s" --direction right --ratio 0.75 --cwd "$DIR" --no-focus | _json '.result.pane.pane_id')

# ── Left column: split top pane down 50/50 for btop
p_btop=$(herdr pane split "$p_k9s" --direction down --ratio 0.5 --cwd "$DIR" --no-focus | _json '.result.pane.pane_id')

# ── Right column: chained down-splits sized so each pane ends up 25% of column height.
p_r2=$(herdr pane split "$p_right_top" --direction down --ratio 0.25  --cwd "$DIR" --no-focus | _json '.result.pane.pane_id')
p_r3=$(herdr pane split "$p_r2"        --direction down --ratio 0.333 --cwd "$DIR" --no-focus | _json '.result.pane.pane_id')
p_r4=$(herdr pane split "$p_r3"        --direction down --ratio 0.5   --cwd "$DIR" --no-focus | _json '.result.pane.pane_id')

# ── Launch the fixed processes
herdr pane run "$p_k9s"  k9s  >/dev/null
herdr pane run "$p_btop" btop >/dev/null

# ── Focus k9s
herdr pane focus --pane "$p_k9s" >/dev/null 2>&1 || true

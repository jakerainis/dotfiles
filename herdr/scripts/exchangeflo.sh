#!/usr/bin/env bash
# ExchangeFlo development layout for herdr — 4×2 apps grid + nvim window.
# Ports sesh/scripts/exchangeflo.sh to the herdr CLI.
#
# Usage: exchangeflo.sh <session_name> [project_dir]

set -euo pipefail

SESSION="${1:?session name required}"
PROJECT="${2:-$HOME/Development/ef}"

command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

# If a workspace with this label already exists, focus and exit.
existing=$(herdr workspace list \
  | jq -r --arg label "$SESSION" '.result.workspaces[] | select(.label == $label) | .workspace_id' \
  | head -1)
if [ -n "$existing" ]; then
  herdr workspace focus "$existing" >/dev/null
  exit 0
fi

direnv allow "$PROJECT" 2>/dev/null || true

_json() { jq -r "$1"; }

# ── Tab 1: apps grid (ef_workers | ef_call_api | ef_publisher_api | ef_portal)
create=$(herdr workspace create --cwd "$PROJECT/apps/ef_workers" --label "$SESSION" --focus)
ws=$(printf '%s' "$create" | _json '.result.workspace.workspace_id')
p_ef_workers=$(printf '%s' "$create" | _json '.result.root_pane.pane_id')

herdr tab rename "${ws}:t1" "apps" >/dev/null 2>&1 || true

# --ratio is the LEFT pane's share. To end up with four equal columns
# after chained right-splits, each new split shrinks the freshly-split-off
# pane to leave equal room for the remaining columns:
#   ef_workers → 1/4, remaining 3/4 splits into 1/3 + 2/3 (i.e. 1/4 + 2/4),
#   remaining 2/4 splits 1/2 + 1/2 (i.e. 1/4 + 1/4).
p_ef_call_api=$(herdr pane split "$p_ef_workers"       --direction right --ratio 0.25  --cwd "$PROJECT/apps/ef_call_api"      --no-focus | _json '.result.pane.pane_id')
p_ef_publisher_api=$(herdr pane split "$p_ef_call_api" --direction right --ratio 0.333 --cwd "$PROJECT/apps/ef_publisher_api" --no-focus | _json '.result.pane.pane_id')
p_ef_portal=$(herdr pane split "$p_ef_publisher_api"   --direction right --ratio 0.5   --cwd "$PROJECT/apps/ef_portal"        --no-focus | _json '.result.pane.pane_id')

# Bottom row: split each column down 50/50 into wr_* siblings.
p_wr_workers=$(herdr pane split "$p_ef_workers"          --direction down --ratio 0.5 --cwd "$PROJECT/apps/wr_workers"     --no-focus | _json '.result.pane.pane_id')
p_wr_event_api=$(herdr pane split "$p_ef_call_api"       --direction down --ratio 0.5 --cwd "$PROJECT/apps/wr_event_api"   --no-focus | _json '.result.pane.pane_id')
p_wr_service_api=$(herdr pane split "$p_ef_publisher_api" --direction down --ratio 0.5 --cwd "$PROJECT/apps/wr_service_api" --no-focus | _json '.result.pane.pane_id')
p_wr_portal=$(herdr pane split "$p_ef_portal"            --direction down --ratio 0.5 --cwd "$PROJECT/apps/wr_portal"      --no-focus | _json '.result.pane.pane_id')

# ── Tab 2: nvim (80/20 split — nvim on left, shell on right)
tab=$(herdr tab create --workspace "$ws" --label "nvim" --cwd "$PROJECT" --focus)
p_nvim=$(printf '%s' "$tab" | _json '.result.root_pane.pane_id')
herdr pane split "$p_nvim" --direction right --ratio 0.8 --cwd "$PROJECT" --no-focus >/dev/null
herdr pane focus --pane "$p_nvim" >/dev/null 2>&1 || true
herdr pane run "$p_nvim" nvim >/dev/null

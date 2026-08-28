#!/usr/bin/env bash
# Create a worktree + branch, then open a herdr workspace with a chosen layout.
#
# Mirrors the tmux-flavored `tbc` zsh function (zsh/.zshrc:145-206) but drives
# herdr instead of tmux. Templates live alongside this script and are picked
# with fzf.
#
# Invocation paths:
#   - herdr keybinding (prefix+shift+e): no args; prompts for template + branch
#   - shell:  wt-new-session.sh [-f base_branch] <branch>
#             wt-new-session.sh [-f base_branch]              # prompts for branch

set -euo pipefail

scripts_dir="$HOME/.config/herdr/scripts"

from_branch=""
if [ "${1:-}" = "-f" ] && [ -n "${2:-}" ]; then
  from_branch="$2"
  shift 2
fi

branch="${1:-}"

# ── Template picker (fzf over scripts/*.sh, excluding this one)
template=$(
  find "$scripts_dir" -maxdepth 1 -name '*.sh' \
    ! -name "$(basename "$0")" \
    -exec basename {} .sh \; \
    | fzf --border-label ' session template ' --prompt '📋  '
)
if [ -z "$template" ]; then
  exit 0
fi

# ── Branch prompt (if not passed as arg)
if [ -z "$branch" ]; then
  printf 'branch: '
  read -r branch
  [ -z "$branch" ] && exit 0
fi

# ── Locate main repo (worktree list's first entry is the primary)
if ! main_path=$(git worktree list 2>/dev/null | head -1 | awk '{print $1}') || [ -z "$main_path" ]; then
  echo "not inside a git repo" >&2
  exit 1
fi
repo_name=$(basename "$main_path")

# ── Create or switch worktree via worktrunk (`wt`)
if git -C "$main_path" show-ref --verify --quiet "refs/heads/$branch"; then
  wt switch "$branch"
elif git -C "$main_path" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  wt switch "$branch"
elif [ -n "$from_branch" ]; then
  wt switch -c "$branch" --base "$from_branch"
else
  wt switch -c "$branch"
fi

# ── Resolve the new worktree path. Use awk `index()` (fixed-string substring
# match), not the `~` regex operator — a branch like `jr/test-wt` becomes the
# character class `[jr/test-wt]` under `~`, which matches virtually every line
# of `git worktree list` and returns the main repo instead of the new worktree.
wt_path=$(git -C "$main_path" worktree list | awk -v b="[$branch]" 'index($0, b){print $1; exit}')
if [ -z "$wt_path" ]; then
  echo "could not locate worktree path for $branch" >&2
  exit 1
fi

direnv allow "$wt_path" 2>/dev/null || true

# ── session_name = <repo>-<branch> (slashes → dashes)
session_name="${repo_name}-$(printf '%s' "$branch" | tr '/' '-')"

# ── Delegate to the template — it drives herdr to build the workspace.
bash "$scripts_dir/${template}.sh" "$session_name" "$wt_path"

# ── Attach the TTY to herdr if we're not already inside it, so the new
# workspace is visible immediately instead of just sitting on the server.
if [ -z "${HERDR_ENV:-}" ]; then
  exec herdr
fi

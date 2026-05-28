# Environment
export EDITOR="nvim"
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml" # lazygit ignores XDG_CONFIG_HOME on macOS

# Completions & Autosuggestions
autoload -Uz compinit && compinit
bindkey -e  # Use emacs keybindings (disable vi mode triggered by EDITOR=nvim)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Tools
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# Common Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias brewdump="brew bundle dump --file=~/dotfiles/Brewfile --force"
alias copyssh="pbcopy < ~/.ssh/id_rsa.pub"
alias dev="cd ~/Development/"
alias docker="/Applications/Docker.app/Contents/Resources/bin/docker"
alias df="cd ~/dotfiles"
alias ll="eza -1 -l --color=always --icons=always"
alias src="source ~/.zshrc"
alias tbl="git worktree list"
alias tml="sesh list -t"
alias tmka="tmux kill-server"
alias v="nvim"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# EF Aliases
alias efc="cd ~/Development/ef/"
alias efd="docker-compose -f dev/docker-compose.yaml up --remove-orphans"
alias efps="cd ~/Development/ef/apps/ef_portal/ && mix deps.get && ./bin/start.dev.sh"
alias efs="source ~/Development/ef/.env"
alias devreset="direnv allow && mix ecto.reset; mix ecto.seed; mix ecto.seed.dev"
alias start="direnv allow && mix deps.get && ./bin/start.dev.sh"
alias testreset="direnv allow && mix deps.get && MIX_ENV=test mix ecto.reset"

###################################
# List all tmux sessions and attach one 
###################################
tma() {
  sesh connect "$(sesh list -t --icons | fzf-tmux -p 80%,70% --no-sort --ansi --border-label " sesh " --prompt "🪟  ")"
}

###################################
# List all tmux sessions and kill one
####################################
tmk() {
  local session
  session=$(sesh list -t | fzf --border-label " kill session " --prompt "💀  ")
  [ -n "$session" ] && tmux kill-session -t "$session"
}

###################################
# Create tmux session from template
####################################
tmc() {
  local scripts_dir="$HOME/.config/sesh/scripts"
  local script
  script=$(ls "$scripts_dir"/*.sh 2>/dev/null | xargs -I{} basename {} .sh | fzf --border-label " session template " --prompt "📋  ")
  if [ -n "$script" ]; then
    local name="${1:-$script}"
    bash "$scripts_dir/$script.sh" "$name"
    tmux attach -t "$name" 2>/dev/null || tmux switch-client -t "$name"
  fi
}

###################################
# List all worktree sessions and kill one 
###################################
tbk() {
  local worktrees
  worktrees=$(git worktree list | tail -n +2)

  if [ -z "$worktrees" ]; then
    echo "No worktrees to remove"
    return 0
  fi

  local selected
  selected=$(echo "$worktrees" | fzf --border-label " remove worktree " --prompt "🗑️  ")
  if [ -z "$selected" ]; then
    return 0
  fi

  # Extract branch name from [branch] in the output
  local branch
  branch=$(echo "$selected" | grep -o '\[.*\]' | tr -d '[]')
  if [ -z "$branch" ]; then
    echo "Could not determine branch name"
    return 1
  fi

  local repo_name=$(basename "$(git worktree list | head -1 | awk '{print $1}')")
  local session_name="${repo_name}-$(echo "$branch" | tr '/' '-')"

  # Kill tmux session if it exists
  tmux kill-session -t "$session_name" 2>/dev/null

  # Remove worktree
  wt remove "$branch"
}

###################################
# Create worktree, branch, session from template
###################################
tbc() {
  local scripts_dir="$HOME/.config/sesh/scripts"
  local from_branch=""

  # Parse -f flag
  if [ "$1" = "-f" ] && [ -n "$2" ]; then
    from_branch="$2"
    shift 2
  fi

  local branch="$1"

  if [ -z "$branch" ]; then
    echo "Usage: tbc [-f base_branch] <branch>"
    return 1
  fi

  # Capture repo info before worktree switch changes cwd
  local main_path=$(git worktree list | head -1 | awk '{print $1}')
  local repo_name=$(basename "$main_path")

  # Pick a template
  local template
  template=$(ls "$scripts_dir"/*.sh 2>/dev/null | xargs -I{} basename {} .sh | fzf --border-label " session template " --prompt "📋  ")
  if [ -z "$template" ]; then
    return 0
  fi

  # Create worktree
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    # Branch exists — create worktree for it
    wt switch "$branch" || return 1
  elif [ -n "$from_branch" ]; then
    # New branch from specified base
    wt switch -c "$branch" --base "$from_branch" || return 1
  else
    # New branch from main
    wt switch -c "$branch" || return 1
  fi

  # Resolve worktree path
  local wt_path
  wt_path=$(git worktree list | grep "\[$branch\]" | awk '{print $1}')
  if [ -z "$wt_path" ]; then
    echo "Could not find worktree path for $branch"
    return 1
  fi

  # Copy .env from main repo if it exists
  if [ -f "$main_path/.env" ] && [ ! -e "$wt_path/.env" ]; then
    ln -s "$main_path/.env" "$wt_path/.env"
  fi

  # Allow direnv for the worktree
  direnv allow "$wt_path" 2>/dev/null

  # Derive session name: repo-branch (slashes become dashes)
  local session_name="${repo_name}-$(echo "$branch" | tr '/' '-')"

  # Create tmux session with template
  local script="$scripts_dir/${template}.sh"
  bash "$script" "$session_name" "$wt_path"
  tmux attach -t "$session_name" 2>/dev/null || tmux switch-client -t "$session_name"
}



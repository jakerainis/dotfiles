# Environment
export EDITOR="nvim"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

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
alias v="nvim"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# Tmux / Sesh Aliases
alias tl="sesh list -t"
alias tla='sesh connect "$(sesh list -t --icons | fzf-tmux -p 80%,70% --no-sort --ansi --border-label " sesh " --prompt "🪟  ")"'
alias tka="tmux kill-server"

# tk — pick a session to kill
tk() {
  local session
  session=$(sesh list -t | fzf --border-label " kill session " --prompt "💀  ")
  [ -n "$session" ] && tmux kill-session -t "$session"
}

# tc — create session from a template script, or ad-hoc with -n <name>
tc() {
  local scripts_dir="$HOME/.config/sesh/scripts"
  if [ "$1" = "-n" ] && [ -n "$2" ]; then
    sesh connect --name "$2" "$(pwd)"
  else
    local script
    script=$(ls "$scripts_dir"/*.sh 2>/dev/null | xargs -I{} basename {} .sh | fzf --border-label " session template " --prompt "📋  ")
    if [ -n "$script" ]; then
      local name="${1:-$script}"
      tmux new-session -d -s "$name" -c "$HOME"
      tmux send-keys -t "$name" "source $scripts_dir/$script.sh" Enter
      tmux attach -t "$name"
    fi
  fi
}

# EF Aliases
alias efc="cd ~/Development/exchange-flo-app/"
alias efd="docker-compose -f dev/docker-compose.yaml up --remove-orphans"
alias efps="cd ~/Development/exchange-flo-app/apps/ef_portal/ && mix deps.get && ./bin/start.dev.sh"
alias efs="source ~/Development/exchange-flo-app/.env"
alias devreset="direnv allow && mix ecto.reset; mix ecto.seed; mix ecto.seed.dev"
alias start="mix deps.get && ./bin/start.dev.sh"
alias testreset="direnv allow && MIX_ENV=test mix ecto.reset"
alias wrps="cd ~/Development/exchange-flo-app/apps/wr_portal/ && mix deps.get && cd assets/ && npm i && cd ../ && ./bin/start.dev.sh"

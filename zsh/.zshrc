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

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias brewdump="brew bundle dump --file=~/dotfiles/Brewfile --force"
alias copyssh="pbcopy < ~/.ssh/id_rsa.pub"
alias dev="cd ~/Development/"
alias docker="/Applications/Docker.app/Contents/Resources/bin/docker"
alias df="cd ~/dotfiles"
alias ll="ls -al -G"
alias src="source ~/.zshrc"
alias tmk="tmux kill-server"
alias v="nvim"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"

# EF helpers
alias efc="cd ~/Development/exchange-flo-app/"
alias efd="docker-compose -f dev/docker-compose.yaml up --remove-orphans"
alias efdata="cd ~/Development/exchange-flo-app/apps/ef_data/"
alias efportal="cd ~/Development/exchange-flo-app/apps/ef_portal/"
alias efpubapi="cd ~/Development/exchange-flo-app/apps/ef_publisher_api/"
alias efs="source ~/Development/exchange-flo-app/.env"

export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
eval "$(starship init zsh)"

plugins=(
  brew
  git
  node
  npm
  nvm
  z
  zsh-autosuggestions
)

COMPLETION_WAITING_DOTS="true"
DEFAULT_USER="$USER"
ENABLE_CORRECTION="true"

alias brewdump="brew bundle dump --file=~/dotfiles/Brewfile --force"
alias copyssh="pbcopy < ~/.ssh/id_rsa.pub"
alias dev="cd ~/Development/"
alias docker="/Applications/Docker.app/Contents/Resources/bin/docker"
alias dotf="~/dotfiles"
alias efc="cd ~/Development/exchange-flo-app/"
alias efd="docker-compose -f dev/docker-compose.yaml up --remove-orphans"
alias rm='trash'
alias src="source ~/.zshrc"
alias vim="nvim"
alias zshconfig="vim ~/.zshrc"

source $ZSH/oh-my-zsh.sh

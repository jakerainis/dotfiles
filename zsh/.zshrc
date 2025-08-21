# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

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
ZSH_THEME="powerlevel10k/powerlevel10k"

alias brewdump="brew bundle dump --file=~/dotfiles/Brewfile --force"
alias copyssh="pbcopy < ~/.ssh/id_rsa.pub"
alias dev="cd ~/Development/"
alias rm='trash'
alias src="source ~/.zshrc"
alias vim="nvim"
alias zshconfig="vim ~/.zshrc"

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

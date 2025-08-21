# Dotfiles

This is a repository of my custom dotfiles and configurations. Do not proceed if you don't know what you're doing as it might overwrite your current configurations.

## Setup

```bash
# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"p
brew install elixir erlang git lazygit neovim nvm opencode-ai/tap/opencode postgresql ripgrep stow zsh # packages
brew install --cask ghostty font-maple-mono-nf # casks 

# install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# clone this repo
git clone git@github.com:jakerainis/dotfiles.git ~/dotfiles

# use stow to symlink dotfiles
cd ~/dotfiles
stow ghostty
stow git 
stow nvim 
stow p10k 
stow zsh 

# manually configure .gitignore 
cp ~/dotfilesgit/.gitignore.local ~/.gitignore
```

---

Inspiration: [https://www.jakewiesler.com/blog/managing-dotfiles](https://www.jakewiesler.com/blog/managing-dotfiles)

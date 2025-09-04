# Dotfiles

This is a repository of my custom dotfiles and configurations. Do not proceed if you don't know what you're doing as it might overwrite your current configurations.

## Setup

```bash
# Clone this repo
 git clone git@github.com:jakerainis/dotfiles.git ~/dotfiles
 cd ~/dotfiles

# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew dependencies from Brewfile
brew bundle --file=./Brewfile

# Install OhMyZSH and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Use stow to symlink dotfiles
stow ghostty
stow git
stow nvim 
stow starship 
stow tmux 
stow zsh 

# Manually configure .gitignore 
cp ~/dotfilesgit/.gitignore.local ~/.gitignore
```

---

Inspiration: [https://www.jakewiesler.com/blog/managing-dotfiles](https://www.jakewiesler.com/blog/managing-dotfiles)

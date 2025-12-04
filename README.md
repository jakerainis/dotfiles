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

# Symlink all dotfiles
./setup.sh
```

---

Inspiration: [https://www.jakewiesler.com/blog/managing-dotfiles](https://www.jakewiesler.com/blog/managing-dotfiles)

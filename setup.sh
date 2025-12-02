#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Stow all config directories into ~/.config
echo "Stowing configs to ~/.config..."
cd "$DOTFILES_DIR"
stow .

# Symlink files that need to live at ~/
echo "Symlinking home directory files..."
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/git/.gitignore.local" ~/.gitignore

echo "Done! You may need to restart your shell or run 'source ~/.zshrc'"

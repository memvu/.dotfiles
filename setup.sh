#!/bin/bash

# Install homebrew and tools (optional)
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing apps..."
cd ~/.dotfiles && brew bundle

# echo "Installing sdkman"
# curl -s "https://get.sdkman.io" | bash
# source "$HOME/.sdkman/bin/sdkman-init.sh"
# echo "Installing java"
# sdk install java
# echo "Installing gradle"
# sdk install gradle

# Symlink dotfiles (optional)
echo "Stowing..."
stow .

# configure global gitignore
git config --global core.excludesfile ~/.gitignore_global

echo "You're all set..."
echo "Well...except for system settings :>>>>"

#!/usr/bin/env bash
set -euo pipefail

# 1. dotfiles: zsh -> ~/.zshenv, ~/.zshrc (home root); rest -> ~/.config/<pkg>/...
stow -t ~ zsh
stow .

# 2. install zsh, oh-my-zsh, volta, ... via home-manager
nix run .#homeConfigurations.sxavity.activationPackage

# 3. make the NIX zsh the login shell.
#    Per-machine + needs root, so home-manager can't do it — this is the one
#    non-portable step. Uses the profile symlink, which survives zsh upgrades
#    and nix-collect-garbage (unlike a hardcoded store path).
if [[ "$(basename "$SHELL")" != zsh ]]; then
  ZSH_PATH="$HOME/.nix-profile/bin/zsh"
  [[ -x "$ZSH_PATH" ]] || { echo "error: $ZSH_PATH not found — nix step failed?"; exit 1; }

  if ! grep -qxF "$ZSH_PATH" /etc/shells 2>/dev/null; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  chsh -s "$ZSH_PATH"
  echo "login shell set to $ZSH_PATH — log out and back in"
else
  echo "login shell is already zsh, skipping chsh"
fi

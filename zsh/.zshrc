export ZSH="$HOME/.nix-profile/share/oh-my-zsh"
export ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"

eval "$(starship init zsh)"

alias ll='ls -la'

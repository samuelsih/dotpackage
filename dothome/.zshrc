export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

alias ll="ls -la"
alias la=tree

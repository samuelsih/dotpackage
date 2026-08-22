HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
FUNCNEST=100

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt AUTOCD
setopt NOBEEP

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Load plugins from ~/.config/zshplugins (see dotconfig/zshplugins/README.md)
ZPLUG="${XDG_CONFIG_HOME:-$HOME/.config}/zshplugins"
source "$ZPLUG/zsh-autosuggestions.plugin.zsh"
source "$ZPLUG/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# Ctrl+Left / Ctrl+Right word jump.
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5C' forward-word
bindkey '^[[5D' backward-word

eval "$(starship init zsh)"

alias ll="ls -la"
alias la=tree
alias vim=nvim
# ==============================================================================
# SetupVibeD — Linux ZSH Configuration
# ==============================================================================

# Saia cedo se o shell não for interativo (evita poluir scripts)
[[ $- != *i* ]] && return

# 1. PATH CONFIGURATION (Must come first!)
# Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# Define PATHs before loading plugins so they can find the tools
for p in \
  "$HOME/.local/bin" \
  "$HOME/.npm-global/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.config/composer/vendor/bin" \
  "$HOME/.local/go/bin" \
  "/usr/local/go/bin" \
  "$HOME/.bun/bin" \
  "$HOME/.rbenv/bin" \
  "/usr/share/doc/python3-impacket/examples" \
  "/snap/bin"
do [[ -d "$p" ]] && PATH="$PATH:$p"; done
export PATH

export GOPATH="$HOME/go"
[[ -d "$GOPATH/bin" ]] && export PATH="$PATH:$GOPATH/bin"


# 2. INIT TOOLS (Env Setup)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
if command -v rbenv >/dev/null; then eval "$(rbenv init -)"; fi


# 3. OH-MY-ZSH CONFIG
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # Prompt colorido customizado abaixo

# Plugins
plugins=(git rsync nmap cp extract zoxide fzf zsh-autosuggestions zsh-syntax-highlighting history-substring-search tmux brew gh ansible docker docker-compose laravel composer rails ruby python pip node npm bun golang rust)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"


# 4. ZOXIDE
if command -v zoxide >/dev/null; then eval "$(zoxide init zsh)"; fi


# 5. KEYBINDINGS & HISTORY SUBSTRING SEARCH
bindkey -M main '^[OA' history-substring-search-up   # Up (modo application)
bindkey -M main '^[OB' history-substring-search-down  # Down (modo application)
bindkey -M main '^[[A' history-substring-search-up    # Up (modo normal)
bindkey -M main '^[[B' history-substring-search-down  # Down 
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# 6. HISTÓRICO: gravar incremental + compartilhar entre sessões
setopt inc_append_history
setopt share_history

# 7. GIT BRANCH NO PROMPT COM VCS_INFO
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

# 8. PROMPT COLORIDO PERSONALIZADO (Hora + Usuário@Host + Diretório + Git Branch)
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{yellow}%n%F{blue}@%F{red}%m  %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f%(!.%F{red}#%f.$) '

# 9. MÓDULOS EXTERNOS
source_if_exists() { [ -f "$1" ] && source "$1"; }
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
source_if_exists "$CONF_DIR/aliases.zsh"
#source_if_exists "$CONF_DIR/functions.zsh"
#source_if_exists "$CONF_DIR/exports.zsh"

# 10. USER CUSTOM CONFIGURATIONS
# Load custom configurations from ~/.zshrc.local if it exists
# Use this file to add your own aliases, functions, and variables.
# This file is never overwritten by SetupVibe updates.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

export MANPAGER="nvim +Man!"

# Hide % sign at EOL
export PROMPT_EOL_MARK=''

# Docker
export DOCKER_BUILDKIT=1

# forgit
export forgit_add=gaf
export forgit_diff=gdf
export forgit_checkout_branch=gch

export FORGIT_LOG_FZF_OPTS="--reverse"
export FORGIT_LOG_FORMAT="%C(auto)%h%Creset -%C(bold red)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Golang
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS=--no-quarantine
export HOMEBREW_FORBIDDEN_FORMULAE="node"

# node/npm
export COREPACK_ENABLE_AUTO_PIN=0

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Rust
# Using static export instead of sourcing ~/.cargo/env to save ~6ms (especially with CrowdStrike)
export PATH="$HOME/.cargo/bin:$PATH"

# zoxide
export _ZO_EXCLUDE_DIRS="$HOME/Downloads/*:$HOME/repos/z/isolation-browser/*:$HOME/.dotfiles/*"

# Helm 3
export PATH="/opt/homebrew/opt/helm@3/bin:$PATH"

# Custom binaries
export PATH="$HOME/.local/bin:$PATH"


# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Hide % sign at EOL
export PROMPT_EOL_MARK=''

# Export homebrew to path
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
else
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Custom binaries
export PATH="$PATH:$(realpath ~/.local/bin)"

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Don’t clear the screen after quitting a manual page.
export MANPAGER="nvim +Man!"

# Color them
export LS_COLORS="$(vivid generate snazzy)"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS=--no-quarantine

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Docker
export DOCKER_BUILDKIT=1

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Golang
export PATH="$PATH:$(go env GOPATH)/bin"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# forgit
export forgit_add=gaf
export forgit_diff=gdf
export forgit_checkout_branch=gch

export FORGIT_LOG_FZF_OPTS="--reverse"
export FORGIT_LOG_FORMAT="%C(auto)%h%Creset -%C(bold red)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"

# zoxide
export _ZO_EXCLUDE_DIRS="$HOME/Downloads/*:$HOME/repos/z/isolation-browser/*:$HOME/.dotfiles/*"

# node/npm
export COREPACK_ENABLE_AUTO_PIN=0

. "$HOME/.cargo/env"

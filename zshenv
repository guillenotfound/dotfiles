# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

export MANPAGER="nvim +Man!"

# Hide % sign at EOL
export PROMPT_EOL_MARK=''

# Custom binaries
export PATH="$PATH:$(realpath ~/.local/bin)"

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

# PERF: this adds somewhere between 15-20ms, leaving it commented since I don't need any Golang binaries as of now
# ❯ hyperfine --shell=none 'go env GOPATH'
# Benchmark 1: go env GOPATH
#   Time (mean ± σ):      12.7 ms ±   0.9 ms    [User: 3.4 ms, System: 2.5 ms]
#   Range (min … max):    10.1 ms …  15.6 ms    228 runs
#
# Golang
# export PATH="$PATH:$(go env GOPATH)/bin"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS=--no-quarantine

# node/npm
export COREPACK_ENABLE_AUTO_PIN=0

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Rust
. "$HOME/.cargo/env"

# zoxide
export _ZO_EXCLUDE_DIRS="$HOME/Downloads/*:$HOME/repos/z/isolation-browser/*:$HOME/.dotfiles/*"

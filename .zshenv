# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Expose postgres binaries
export PATH=/opt/homebrew/opt/postgresql@10/bin:$PATH

# Editor
export EDITOR='nvim'

# Don’t clear the screen after quitting a manual page.
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS=--no-quarantine

# pip
export PATH=/home/ubuntu/.local/bin:$PATH

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Docker
export DOCKER_BUILDKIT=1

# Golang
export GOPATH=$HOME/go
export GOROOT="/usr/local/go"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Node
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Rust
. "$HOME/.cargo/env"

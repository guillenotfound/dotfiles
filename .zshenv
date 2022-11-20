# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Export homebrew to path
export PATH="/opt/homebrew/bin:$PATH"

# Expose postgres binaries
export PATH=/opt/homebrew/opt/postgresql@14/bin:$PATH

# Editor
export EDITOR='nvim'

# Don’t clear the screen after quitting a manual page.
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Color them
export LS_COLORS="$(vivid generate snazzy)"

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS=--no-quarantine

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Docker
export DOCKER_BUILDKIT=1

# Golang
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix go)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

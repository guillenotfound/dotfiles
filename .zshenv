# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Expose postgres binaries
export PATH=/opt/homebrew/opt/postgresql@10/bin:$PATH

# Editor
export EDITOR='nvim'

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Do not auto-update homebrew packages by default
export HOMEBREW_NO_AUTO_UPDATE=1

# Set IPDB as default debugger
export PYTHONBREAKPOINT=ipdb.set_trace

# Docker
export DOCKER_BUILDKIT=1

# Golang
export GOPATH=$HOME/go
export GOROOT="/opt/homebrew/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


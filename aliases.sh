#!/usr/bin/env bash

# Aliases to work with sudo
alias sudo="sudo "

alias code.="code ."

# nvim
alias vim=nvim
function view() {
  vim -R "$@"
}

function vimdiff() {
  vim -d "$@"
}

# Git
alias g="git"
# compdef g="git"

function gd() {
  git diff "$@" -- ':(exclude)yarn.lock' ':(exclude)package-lock.json' ':(exclude)Pipfile.lock'
}

function gds() {
  git diff --staged "$@" -- ':(exclude)yarn.lock' ':(exclude)package-lock.json' ':(exclude)Pipfile.lock'
}

# Source: https://www.adamsdesk.com/posts/manage-git-stash-command-line-fzf/#how-to-install-gsl
# git stash with fzf
function gsl {
  git stash list --pretty="format:%<(11)%C(yellow)%gd %Cgreen%ci %C(blue)%s" "$argv" | fzf -0 --ansi --header 'ID          Date                      Message' --preview 'git stash show -p {1}' --preview-window up,wrap,80% --preview-label='[ Git Stashes ]' --preview-label-pos=3 --bind 'enter:execute(git stash show {1};read -p "Press any key to resume"),alt-d:reload(git stash drop {1};git stash list --pretty="format:%<(11)%C(yellow)%gd %Cgreen%ci %C(blue)%s" $argv),alt-p:reload(git stash pop {1};git stash list --pretty="format:%<(11)%C(yellow)%gd %Cgreen%ci %C(blue)%s" $argv)'
}

alias ga="git add"
alias gaa="git add -A"
alias gap="git add -p"
alias gc="git commit -v"
alias c="git commit -m"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gnope="git checkout ."
alias gwait="git reset HEAD"
alias gundo="git reset HEAD~"
alias gco="git co"
alias gl="git pull"
#alias glo="git pull origin"
alias gm="git merge - --no-ff"
alias gp="git push"
alias gpo="git push origin"
alias gst="git st"

# Python
alias python="python3"
alias pip="pip3"
alias ve="python3 -m venv .venv"
alias va="source .venv/bin/activate"
alias vd="deactivate"
alias pir="pip install -r requirements.txt"
alias pird="pip install -r requirements-dev.txt"
alias flake8-lint="flake8 --max-line-length 139 --extend-exclude=.venv"
alias black-fmt="black . --line-length 139 --skip-string-normalization"

# Docker
# compdef: command or service unknown: docker
# $ docker completion zsh > $(brew --prefix)/share/zsh/site-functions
if command -v docker >/dev/null 2>&1; then
  alias d="docker"
  # compdef d="docker"

  alias dc="docker compose"
  # compdef _docker dc="docker"

  alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'
fi

# Kubernetes
alias k="kubectl"

alias kx="kubectx"
alias kn="kubens"

# ip addresses
alias ip="curl ifconfig.me"
alias localip="ipconfig getifaddr en0"

# Clean up .DS_Store
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Get macOS Software Updates, and update installed Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g;'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Preserve ssh connections
alias autossh='autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" '

# Get ports in use
alias used-ports='lsof -iTCP -sTCP:LISTEN -P -n'

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# https://github.com/sharkdp/vivid?tab=readme-ov-file#on-macos
alias ls="ls --color=auto"

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
autoload -Uz compinit && compinit -i

setopt interactivecomments # enable comments

# Completions
# By default Brew installs them to "$(brew --prefix)/share/zsh/site-functions"
#
# Normally do something like `docker completion zsh > $(brew --prefix)/share/zsh/site-functions` when completions are missing
#
# Fix docker exec autocomplete
# https://github.com/moby/moby/commit/402caa94d23ea3ad47f814fc1414a93c5c8e7e58
if command -v docker &> /dev/null; then
  zstyle ':completion:*:*:docker:*' option-stacking yes
  zstyle ':completion:*:*:docker-*:*' option-stacking yes
  source <(docker completion zsh)
fi

if command -v npm &> /dev/null; then
  source <(npm completion zsh)
fi

if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

if command -v pnpm &> /dev/null; then
  source <(pnpm completion zsh)
fi

if command -v tailscale &> /dev/null; then
  source <(tailscale completion zsh)
fi

# Load custom functions
FPATH="${FPATH}:${HOME}/.dotfiles/functions"
autoload -Uz batdiff bcp bip bup cap dt2h mac-is-linux ret send-wapp transfer


# Load ZSH plugins
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.zsh/plugins/forgit/forgit.plugin.zsh

source ~/.zsh/plugins/hhighlighter/h.sh

# Load some stuffs from ohmyzsh
source ~/.zsh/ohmyzsh/lib/completion.zsh
#source ~/.zsh/ohmyzsh/lib/correction.zsh
source ~/.zsh/ohmyzsh/lib/directories.zsh
source ~/.zsh/ohmyzsh/lib/grep.zsh
source ~/.zsh/ohmyzsh/lib/history.zsh
source ~/.zsh/ohmyzsh/lib/key-bindings.zsh
source ~/.zsh/ohmyzsh/lib/theme-and-appearance.zsh

source ~/.zsh/ohmyzsh/plugins/extract/extract.plugin.zsh


eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


# Enables key bindings and fuzzy completion
# source <(fzf --zsh)


# Load custom aliases
source ~/.dotfiles/aliases.sh

# Load custom stuffs
[ -f ~/.custom ] && source ~/.custom

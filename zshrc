# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# PERF: this does a good hit, check what's going on
autoload -Uz compinit && compinit -i


#
# Oh My ZSH related config (to avoid loading this that I don't need)

# https://github.com/ohmyzsh/ohmyzsh/blob/f8022980a3423f25e3d5e1b6a60d2372a2ba006b/lib/misc.zsh#L20
setopt interactivecomments # enable comments


#
# Load Oh My ZSH
source ~/.zsh/ohmyzsh/lib/completion.zsh
# TODO: I use very little from this one, only the dot aliases
source ~/.zsh/ohmyzsh/lib/directories.zsh
source ~/.zsh/ohmyzsh/lib/grep.zsh
# TODO: history might not be needed as I'm using atuin
source ~/.zsh/ohmyzsh/lib/history.zsh
source ~/.zsh/ohmyzsh/lib/key-bindings.zsh
# Using vivid instead
# source ~/.zsh/ohmyzsh/lib/theme-and-appearance.zsh

#
# Load other plugins
source ~/.zsh/ohmyzsh/plugins/extract/extract.plugin.zsh

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# TODO: check if used
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.zsh/plugins/forgit/forgit.plugin.zsh

source ~/.zsh/plugins/hhighlighter/h.sh

source ~/.zsh/plugins/zsh-lazyload/zsh-lazyload.zsh


#
# Load core utilities
#
# NOTE: order matters as there are some scripts related with OhMyZSH that
# modify keybindings, this is specially relevant for atuin
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


#
# Load custom functions
FPATH="${FPATH}:${HOME}/.dotfiles/functions"
autoload -Uz bcp bip bup cap clean-zoxide-entries dt2h mac-is-linux ret send-wapp

#
# Load aliases
source ~/.dotfiles/aliases.sh

#
# Load custom stuffs (this file is never commited)
[ -f ~/.custom ] && source ~/.custom


# TODO: review this comment
# Completions
# By default Brew installs them to "$(brew --prefix)/share/zsh/site-functions"
#
# Normally do something like `docker completion zsh > $(brew --prefix)/share/zsh/site-functions` when completions are missing
#
# Fix docker exec autocomplete
# https://github.com/moby/moby/commit/402caa94d23ea3ad47f814fc1414a93c5c8e7e58
if command -v docker &>/dev/null; then
  zstyle ':completion:*:*:docker:*' option-stacking yes
  zstyle ':completion:*:*:docker-*:*' option-stacking yes
  lazyload docker -- 'source <(docker completion zsh)'
fi

if command -v npm &>/dev/null; then
  lazyload npm -- 'source <(npm completion)'
fi

if command -v kubectl &>/dev/null; then
  lazyload kubectl -- 'source <(kubectl completion zsh)'
fi

if command -v pnpm &>/dev/null; then
  lazyload pnpm -- 'source <(pnpm completion zsh)'
fi

if command -v tailscale &>/dev/null; then
  lazyload tailscale -- 'source <(tailscale completion zsh)'
fi

if command -v tsh &>/dev/null; then
  lazyload tsh -- 'eval "$(tsh --completion-script-zsh)"'
fi

# Final ideas
#
# Things such as `h` can also be lazy loaded maybe, is it worth?

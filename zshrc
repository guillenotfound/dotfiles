# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# On Linux we need to add this in the .zshrc
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


#
# Load custom stuffs (this file is never commited)
[ -f ~/.custom ] && source ~/.custom


#
# Load custom functions
FPATH="${FPATH}:${HOME}/.dotfiles/functions"
autoload -Uz bcp bip bup cap clean-zoxide-entries dt2h mac-is-linux ret send-wapp

#
# Load aliases
source ~/.dotfiles/aliases.sh


# Speed up completion init, see: https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C


#
# Oh My ZSH related config (to avoid loading things that I don't use)

setopt interactive_comments # Comments even in interactive shells.

setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.
setopt pushd_minus          # Swap the meaning of cd +1 and cd -1 to the opposite.

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data


#
# Load Oh My ZSH
source ~/.zsh/ohmyzsh/lib/completion.zsh
# source ~/.zsh/ohmyzsh/lib/grep.zsh
# source ~/.zsh/ohmyzsh/lib/history.zsh
source ~/.zsh/ohmyzsh/lib/key-bindings.zsh


#
# Load other plugins
source ~/.zsh/ohmyzsh/plugins/extract/extract.plugin.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# TODO: Try adding lazy load to forgit
source ~/.zsh/plugins/forgit/forgit.plugin.zsh
source ~/.zsh/plugins/hhighlighter/h.sh
source ~/.zsh/plugins/zsh-lazyload/zsh-lazyload.zsh


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

if command -v pnpm &>/dev/null; then
  lazyload pnpm -- 'source <(pnpm completion zsh)'
fi

if command -v tailscale &>/dev/null; then
  lazyload tailscale -- 'source <(tailscale completion zsh)'
fi

if command -v tsh &>/dev/null; then
  lazyload tsh -- 'eval "$(tsh --completion-script-zsh)"'
fi

#
# Load core utilities
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --no-cmd)"
FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source <(fzf --zsh)

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Enable shell completion
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# PERF: `brew --prefix` adds some extra MS
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit


function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

##########

# TODO: use a glob instead!
if [[ ! -e ~/functions/batdiff.zwc ]]; then
  zcompile-many ~/functions/*
fi

FPATH="$HOME/functions:${FPATH}"

##########

mkdir -p ~/.zsh/plugins

if [[ ! -e ~/.zsh/ohmyzsh ]]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.zsh/ohmyzsh
  zcompile-many $ZSH/oh-my-zsh.sh
  zcompile-many $ZSH/lib/*.zsh
  zcompile-many $ZSH/plugins/**/*.zsh
  zcompile-many $ZSH/plugins/**/_*
fi

if [[ ! -e ~/.zsh/plugins/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
  zcompile-many ~/.zsh/plugins/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
fi

if [[ ! -e ~/.zsh/plugins/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/plugins/zsh-autosuggestions
  zcompile-many ~/.zsh/plugins/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi

if [[ ! -e ~/.zsh/plugins/forgit ]]; then
  git clone --depth=1 https://github.com/wfxr/forgit.git ~/.zsh/plugins/forgit
  zcompile-many ~/.zsh/plugins/forgit/forgit.plugin.zsh
fi

unfunction zcompile-many

source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/forgit/forgit.plugin.zsh

source ~/.zsh/ohmyzsh/lib/completion.zsh
#source ~/.zsh/ohmyzsh/lib/correction.zsh
source ~/.zsh/ohmyzsh/lib/directories.zsh
source ~/.zsh/ohmyzsh/lib/grep.zsh
source ~/.zsh/ohmyzsh/lib/history.zsh
source ~/.zsh/ohmyzsh/lib/key-bindings.zsh
source ~/.zsh/ohmyzsh/lib/theme-and-appearance.zsh

source ~/.zsh/ohmyzsh/plugins/extract/extract.plugin.zsh



# Load custom functions
autoload -Uz batdiff bcp bip bup cap dt2h mac-is-linux ret send-wapp transfer

# Load custom aliases
source ~/.aliases

# Load custom stuffs
[ -f ~/.custom ] && source ~/.custom

# Enables key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

[[ -d ~/.zsh/plugins ]] || mkdir -p ~/.zsh/plugins

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

if [ -z "$(find ~/.dotfiles/functions/ -name '*.zwc' -print -quit)" ]; then
  zcompile-many ~/.dotfiles/functions/*
fi

if [[ ! -e ~/.zsh/ohmyzsh ]]; then
  ZSH_DIR="$HOME/.zsh/ohmyzsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
  zcompile-many $ZSH_DIR/oh-my-zsh.sh
  zcompile-many $ZSH_DIR/lib/*.zsh
  zcompile-many $ZSH_DIR/plugins/**/*.zsh
  zcompile-many $ZSH_DIR/plugins/**/_*
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

if [[ ! -e ~/.zsh/plugins/hhighlighter ]]; then
  git clone --depth=1 https://github.com/paoloantinori/hhighlighter.git ~/.zsh/plugins/hhighlighter
  zcompile-many ~/.zsh/plugins/hhighlighter/h.sh
fi

unfunction zcompile-many

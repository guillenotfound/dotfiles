# Not using uname to avoid creating a subshell:
# https://github.com/mrnugget/dotfiles/commit/6c900a120795cea99bf76de6aa0bc3c5346d2b38#r47491276
# https://github.com/mrnugget/dotfiles/commit/f3eabc74c5297e7328c8252a00f1e3af1c03c9f4
#
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# On MacOS we need to add this in the .zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add colors to files and directories
export LS_COLORS="$(vivid generate snazzy)"

[[ -d ~/.zsh/plugins ]] || mkdir -p ~/.zsh/plugins


# NOTE: Check if the following lines are taking long, for instance the find and
# potentially remove them and remove everything & create the compalied files
# back again

# TODO: check if compiling makes any difference
# TODO: refactor and simplify such that zcompile-many is called once
# TODO: have an easy way to update (rm -rf ~/.zsh)
function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

if [ -z "$(find ~/.dotfiles/functions/ -name '*.zwc' -print -quit)" ]; then
  zcompile-many ~/.dotfiles/functions/*
fi

if [[ ! -e ~/.zsh/ohmyzsh ]]; then
  OH_MY_ZSH_DIR="$HOME/.zsh/ohmyzsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR"
  zcompile-many "$OH_MY_ZSH_DIR"/oh-my-zsh.sh
  zcompile-many "$OH_MY_ZSH_DIR"/lib/*.zsh
  zcompile-many "$OH_MY_ZSH_DIR"/plugins/**/*.zsh
  zcompile-many "$OH_MY_ZSH_DIR"/plugins/**/_*
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

if [[ ! -e ~/.zsh/plugins/zsh-lazyload ]]; then
  git clone --depth=1 https://github.com/qoomon/zsh-lazyload.git ~/.zsh/plugins/zsh-lazyload
  zcompile-many ~/.zsh/plugins/zsh-lazyload/*.zsh
fi

unfunction zcompile-many

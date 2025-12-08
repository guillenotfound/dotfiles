# Not using uname to avoid creating a subshell:
# https://github.com/mrnugget/dotfiles/commit/6c900a120795cea99bf76de6aa0bc3c5346d2b38#r47491276
# https://github.com/mrnugget/dotfiles/commit/f3eabc74c5297e7328c8252a00f1e3af1c03c9f4
#
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# On MacOS we need to add this in the .zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Leaving this here in case it needs re-generation
  # eval "$(/opt/homebrew/bin/brew shellenv)"

  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  fpath[1,0]="/opt/homebrew/share/zsh/site-functions";
  eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
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

# Skip the slow find command - just check if one compiled file exists
if [[ ! -f ~/.dotfiles/functions/bcp.zwc ]]; then
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

if [[ ! -e ~/.zsh/plugins/zsh-defer ]]; then
  git clone --depth=1 git@github.com:romkatv/zsh-defer.git ~/.zsh/plugins/zsh-defer
  zcompile-many ~/.zsh/plugins/zsh-defer/zsh-defer.plugin.zsh
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

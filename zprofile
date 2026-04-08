# PERF: Not using uname to avoid creating a subshell:
# https://github.com/mrnugget/dotfiles/commit/6c900a120795cea99bf76de6aa0bc3c5346d2b38#r47491276
# https://github.com/mrnugget/dotfiles/commit/f3eabc74c5297e7328c8252a00f1e3af1c03c9f4
#
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# On MacOS we need to add this in the .zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ ! -e ~/.zsh/ohmyzsh ]]; then
  OH_MY_ZSH_DIR="$HOME/.zsh/ohmyzsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR"
fi

if [[ ! -e ~/.zsh/plugins/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
fi

if [[ ! -e ~/.zsh/plugins/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/plugins/zsh-autosuggestions
fi

if [[ ! -e ~/.zsh/plugins/forgit ]]; then
  git clone --depth=1 https://github.com/wfxr/forgit.git ~/.zsh/plugins/forgit
fi

if [[ ! -e ~/.zsh/plugins/hhighlighter ]]; then
  git clone --depth=1 https://github.com/paoloantinori/hhighlighter.git ~/.zsh/plugins/hhighlighter
fi


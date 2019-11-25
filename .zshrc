# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/adb
    zgen oh-my-zsh plugins/z
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/sublime
    # zgen oh-my-zsh plugins/taskwarrior
    zgen oh-my-zsh plugins/minikube

    # Syntax highlighting bundle.
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load lukechilds/zsh-better-npm-completion

    # Other plugins
    zgen load djui/alias-tips

    # Theme
    zgen load mafredri/zsh-async
    zgen load sindresorhus/pure

    # generate the init script from plugins above
    zgen save
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit

source ~/.dotfiles/.alias
source ~/.dotfiles/.export
source ~/.dotfiles/.functions
source ~/.dotfiles/.python

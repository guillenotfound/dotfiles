eval "$(starship init zsh)"

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose
    zgen oh-my-zsh plugins/kubectl
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/z

    zgen load 'wfxr/forgit'

    # Syntax highlighting bundle.
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    # generate the init script from plugins above
    zgen save
fi

# Enables key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Hide environment variables from zsh completion
# Alternative: https://serverfault.com/a/1031560
# https://serverfault.com/a/1081038
zstyle ':completion:*:-command-:*' tag-order '!parameters'

source ~/.aliases
source ~/.functions
source ~/.custom || true

# Other completions
source <(npm completion)
source <(kubectl completion zsh)
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
eval $(starship completions zsh)

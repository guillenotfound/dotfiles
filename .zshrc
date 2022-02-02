# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/gcloud
    zgen oh-my-zsh plugins/sublime
    zgen oh-my-zsh plugins/z

    # Syntax highlighting bundle.
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting

    # Other plugins
    zgen load djui/alias-tips

    # generate the init script from plugins above
    zgen save
fi

# Load prompt
autoload -U promptinit; promptinit
prompt pure

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.aliases
source ~/.functions
source ~/.custom || true

# Other completions
source <(kubectl completion zsh)
source <(npm completion)
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"


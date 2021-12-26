#!/bin/bash

cd $HOME

git init
git remote add origin git@github.com:guillenotfound/dotfiles.git
git fetch
git reset --hard origin master

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -sf .config/nvim/init.vim .vimrc

[ -d Screenshots ] || mkdir Screenshots
defaults write com.apple.screencapture location "${HOME}/Screenshots"

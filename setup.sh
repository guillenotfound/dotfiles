#!/bin/bash

cd $HOME

git init
git remote add origin git@github.com:guillenotfound/dotfiles.git
git reset --hard origin master

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s .config/nvim/init.vim .vimrc

touch .hushlogin

mkdir Screenshots
defaults write com.apple.screencapture location $(pwd)/Screenshots

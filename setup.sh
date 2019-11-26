#!/bin/bash

cd $HOME

git init
git remote add origin git@github.com:ZiFFeL1992/dotfiles.git
git reset --hard origin master

ln -s .config/nvim/init.vim .vimrc

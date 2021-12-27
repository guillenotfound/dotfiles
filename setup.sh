#!/bin/bash

cd $HOME

git init
git remote add origin git@github.com:guillenotfound/dotfiles.git
git fetch
git reset --hard origin master

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}

# Create repositories dir
[ -d repos ] || mkdir repos

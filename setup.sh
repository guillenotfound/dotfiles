#!/bin/bash

cd $HOME

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

git init
git remote add origin git@github.com:guillenotfound/dotfiles.git
git fetch
git reset --hard origin/master

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}

# Create repositories dir
mkdir -p $HOME/{repos,Screenshots}

#!/bin/bash

cd $HOME

echo "------------------------------"

if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Installing Xcode Command Line Tools."
  # Install Xcode command line tools
  xcode-select --install
fi

git init
git remote add origin git@github.com:guillenotfound/dotfiles.git
git fetch
git reset --hard origin/master

# Create repositories dir
mkdir -p $HOME/{repos,Screenshots}

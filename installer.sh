#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install dependencies from Brewfile
brew bundle install

# To install useful key bindings and fuzzy completion
$(brew --prefix)/opt/fzf/install

# Install zgen
[[ -d "${HOME}/.zgen" ]] || git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# Install Tmux Plugin Manager
[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugin manager for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Link vim config
ln -sf .config/nvim/init.vim .vimrc

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}

# Configure latest Node LTS
sudo n lts

# Install global npm packages
npm i -g npkill npm-check npm-check-updates vite ts-node https://github.com/victor141516/git-o

source ./helpers/ask.sh

ask "Do you want to install Google Cloud add-ons?"
gcloud_addons=$?

ask "Do you want to install Cloud SQL Proxy?"
cloud_sql_proxy=$?

if [ $gcloud_addons -eq 1 ]; then
  yes | gcloud components install beta
  yes | gcloud components install bq
  yes | gcloud components install gsutil
fi

if [ $cloud_sql_proxy -eq 1 ]; then
  go install github.com/GoogleCloudPlatform/cloud-sql-proxy/v2@latest
fi

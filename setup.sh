#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ "$(uname)" == "Darwin" ]; then
  echo "------------------------------"
  echo "Installing Xcode Command Line Tools."
  # Install Xcode command line tools
  if ! xcode-select --version 2>&1 >/dev/null; then
    xcode-select --install
  fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  apt update && apt install -y build-essential procps curl file git
fi

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

export PATH="/opt/homebrew/bin/:/home/linuxbrew/.linuxbrew/bin/brew:$PATH"

# Install dependencies from Brewfile
brew update && brew upgrade
brew bundle --file=~/.dotfiles/Brewfile install

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Install Node LTS
# https://github.com/tj/n?tab=readme-ov-file#installation
sudo n lts --no-use-xz
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Install Node global deps
sudo npm i -g npm-check-updates tsx pnpm

# Create custom directories
mkdir -p $HOME/{repos,Screenshots}

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}

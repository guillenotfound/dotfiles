#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ "$(uname)" == "Darwin" ]; then
  echo "------------------------------"
  echo "Installing Xcode Command Line Tools."
  # Install Xcode command line tools
  xcode-select --install
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  apt update && apt install -y curl git build-essential
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
$(brew --prefix)/opt/fzf/install
rm -rf ~/.fzf.bash

# Install Node LTS
sudo n lts --no-use-xz

# Install Node global deps
npm i -g npm-check-updates tsx pnpm

# Create custom directories
mkdir -p $HOME/{repos,Screenshots}

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}

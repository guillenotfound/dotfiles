#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


# Install dependencies from Brewfile
brew update && brew upgrade
brew bundle -f ~/.dotfiles/Brewfile install

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
rm -rf ~/.fzf.bash

# Install Node LTS
sudo n lts

# Create custom directories
mkdir -p $HOME/{repos,Screenshots}

# Create Golang dirs
mkdir -p $HOME/go/{bin,src,pkg}


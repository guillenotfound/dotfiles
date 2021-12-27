#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Change default shell to zsh
sudo dscl . -create /Users/$USER UserShell /opt/homebrew/bin/zsh

echo "------------------------------"
echo "Opening iTerm.app..."
sleep 5

open -a iTerm.app

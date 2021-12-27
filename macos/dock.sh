#!/bin/sh

# Set the icon size of Dock items to 60 pixels
defaults write com.apple.dock tilesize -int 60

# Set the dock to autohide
defaults write com.apple.Dock autohide -bool true

# Set the dock autohide delay to 0
defaults write com.apple.Dock autohide-delay -float 0

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Spotify.app"

killall Dock

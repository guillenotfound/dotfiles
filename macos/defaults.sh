#!/bin/sh

COMPUTER_NAME="underwater"

osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Modify top bar menu items
# defaults write com.apple.systemuiserver menuExtras -array \
#   "/System/Library/CoreServices/Menu Extras/VPN.menu"

# Display Bluetooth icon
# https://community.jamf.com/t5/jamf-pro/show-bluetooth-in-menu-bar/td-p/235435
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: enable three finger drag
# https://apple.stackexchange.com/a/445718
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Save screenshots to a screenshots folder on the desktop
defaults write com.apple.screencapture location -string "$HOME/Screenshots"

# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/Library/Preferences"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Automatically switch appearance
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

source ./helpers/ask.sh

ask "Should configure Transmission?"
transmission=$?

if [ $transmission -eq 1 ]; then
  ###############################################################################
  # Transmission.app                                                            #
  ###############################################################################

  # Use `~/Documents/Torrents` to store incomplete downloads
  defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
  defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

  # Use `~/Downloads` to store completed downloads
  defaults write org.m0k.transmission DownloadLocationConstant -bool true

  # Don’t prompt for confirmation before downloading
  defaults write org.m0k.transmission DownloadAsk -bool false
  defaults write org.m0k.transmission MagnetOpenAsk -bool false

  # Don’t prompt for confirmation before removing non-downloading active transfers
  defaults write org.m0k.transmission CheckRemoveDownloading -bool true

  # Trash original torrent files
  defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

  # Hide the donate message
  defaults write org.m0k.transmission WarningDonate -bool false
  # Hide the legal disclaimer
  defaults write org.m0k.transmission WarningLegal -bool false

  # Randomize port on launch
  defaults write org.m0k.transmission RandomPort -bool true
fi

killall SystemUIServer

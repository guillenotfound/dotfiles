#!/bin/sh

COMPUTER_NAME="underwater"

osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# NOTE: useful tools:
# https://github.com/8ta4/plist
# https://github.com/catilac/plistwatch

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set computer name (as done via System Preferences → Sharing)
# sudo scutil --set ComputerName "$COMPUTER_NAME"
# sudo scutil --set HostName "$COMPUTER_NAME"
# sudo scutil --set LocalHostName "$COMPUTER_NAME"
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

# Display Bluetooth icon in menu bar
# https://community.jamf.com/t5/jamf-pro/show-bluetooth-in-menu-bar/td-p/235435
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Trackpad
# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write 'Apple Global Domain' com.apple.mouse.tapBehavior 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three finder dragging
defaults write com.apple.AppleMultitouchTrackpad Dragging '0'
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag '1'
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag '1'

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Save screenshots to a screenshots folder on the desktop
defaults write com.apple.screencapture location -string "~/Screenshots"

# Automatically switch appearance
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

# Remove all icons from Dock
defaults write com.apple.dock persistent-apps -array && killall Dock

# Disable some default shortcuts (ctrl+up/down)
# https://apple.stackexchange.com/a/434159
# https://krypted.com/mac-os-x/defaults-symbolichotkeys/
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 32 "{enabled = 0; value = { parameters = (65535, 125, 8650752); type = 'standard'; }; }"
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 33 "{enabled = 0; value = { parameters = (65535, 126, 8650752); type = 'standard'; }; }"
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:32:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:33:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# Autohide dock
defaults write com.apple.dock autohide -bool "true"

# Dark mode
defaults write "Apple Global Domain" "AppleInterfaceStyle" 'Dark'

killall SystemUIServer
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u


###############################################################################
# code.app                                                                    #
###############################################################################
# Enable press and hold (key repeats)
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false
defaults delete -g ApplePressAndHoldEnabled


###############################################################################
# iterm2.app                                                                  #
###############################################################################
# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true


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


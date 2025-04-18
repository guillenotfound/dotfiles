#!/usr/bin/env bash

DOTFILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/zprofile" ~/.zprofile
ln -sf "$DOTFILES_DIR/custom" ~/.custom

ln -sf "$DOTFILES_DIR/hushlogin" ~/.hushlogin

ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

ln -sf "$DOTFILES_DIR/gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/gitconfig_work" ~/.gitconfig_work
ln -sf "$DOTFILES_DIR/gitignore_global" ~/.gitignore_global

ln -sf "$DOTFILES_DIR/rgignore" ~/.rgignore

ln -sf "$DOTFILES_DIR/czrc" ~/.czrc

ln -sf "$DOTFILES_DIR/curlrc" ~/.curlrc

ln -sf "$DOTFILES_DIR/wezterm.lua" ~/.wezterm.lua

ln -sfn "$DOTFILES_DIR/hammerspoon" ~/.hammerspoon

mkdir -p ~/.config
ln -sfn "$DOTFILES_DIR/config/bat" ~/.config/bat
ln -sfn "$DOTFILES_DIR/config/ghostty" ~/.config/ghostty
ln -sfn "$DOTFILES_DIR/config/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/config/zed" ~/.config/zed
ln -sf "$DOTFILES_DIR/config/starship.toml" ~/.config/starship.toml

# TODO: this should be moved somewhere else
bat cache --build

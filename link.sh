#!/usr/bin/env bash

DOTFILES_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zshenv" ~/.zshenv
ln -sf "$DOTFILES_DIR/.zprofile" ~/.zprofile

ln -sf "$DOTFILES_DIR/.hushlogin" ~/.hushlogin

ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf

ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global

ln -sf "$DOTFILES_DIR/.rignore" ~/.rignore

ln -sf "$DOTFILES_DIR/.czrc" ~/.czrc

ln -sf "$DOTFILES_DIR/.curlrc" ~/.curlrc

ln -sf "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/.config/bat/config" ~/.config/bat/config


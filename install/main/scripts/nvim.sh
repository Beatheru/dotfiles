#!/bin/bash

# Setup Neovim
log INFO "Setting up Neovim"
rm -rf ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
#!/bin/bash

# Update system
log INFO "Updating system"
sudo pacman -Syu --noconfirm

# Install Paru
log INFO "Installing Paru"
sudo pacman -S --noconfirm --needed base-devel
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/paru
fi
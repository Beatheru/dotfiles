#!/bin/bash

# Fix Niri high VRAM usage with NVIDIA. See https://yalter.github.io/niri/Nvidia.html
if [[ -n "$(lspci | grep -iE 'vga|3d|display' | grep -i 'NVIDIA')" ]]; then
  log INFO "Fixing Niri VRAM issues with Nvidia"
  mkdir -p /etc/nvidia/nvidia-application-profiles-rc.d
  sudo cp -f $INSTALL_CONFIGS/niri/50-limit-free-buffer-pool-in-wayland-compositors.json /etc/nvidia/nvidia-application-profiles-rc.d/
fi

# Set gtk settings
log INFO "Setting gtk settings"
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Kora'
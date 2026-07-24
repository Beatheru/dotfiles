# Fix Niri high VRAM usage with NVIDIA. See https://yalter.github.io/niri/Nvidia.html
if has_nvidia; then
  sudo mkdir -p /etc/nvidia/nvidia-application-profiles-rc.d
  sudo cp -f "$INSTALL_CONFIGS/nvidia/50-limit-free-buffer-pool-in-wayland-compositors.json" /etc/nvidia/nvidia-application-profiles-rc.d/
fi

# Set gtk settings
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Kora'
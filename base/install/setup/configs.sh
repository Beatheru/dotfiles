log INFO "Symlinking configs with stow"
stow -d "$INSTALL_CONFIGS" -t ~ --no-folding bash fastfetch ghostty

sudo cp -f "$INSTALL_CONFIGS/pacman/pacman.conf" /etc/pacman.conf

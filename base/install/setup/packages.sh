log INFO "Installing packages"
sudo cp -f "$INSTALL_CONFIGS/pacman/pacman.conf" /etc/pacman.conf
mapfile -t packages < <(grep -v '^#' "$INSTALL_SCRIPTS/setup/packages.list" | grep -v '^$')
paru -S --noconfirm --needed "${packages[@]}"
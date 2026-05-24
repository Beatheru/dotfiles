log INFO "Installing packages"
mapfile -t packages < <(grep -v '^#' "$INSTALL_SCRIPTS/packages.list" | grep -v '^$')
paru -S --noconfirm --needed "${packages[@]}"
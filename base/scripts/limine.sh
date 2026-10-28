sudo cp "$INSTALL_CONFIGS/limine/default.conf" /etc/default/limine
sudo mkdir -p /etc/pacman.d/hooks
sudo cp "$INSTALL_CONFIGS/limine/99-limine.hook" /etc/pacman.d/hooks

sudo limine-install
sudo limine-update

# Add styling
TMPFILE=$(mktemp)
cat > "$TMPFILE" << 'EOF'
term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
term_background: 1e1e2e
term_foreground: cdd6f4
term_background_bright: 585b70
term_foreground_bright: cdd6f4

EOF
cat /boot/limine.conf >> "$TMPFILE"
sudo mv "$TMPFILE" /boot/limine.conf

# Setup Snapper with Limine
if ! sudo snapper list-configs 2>/dev/null | grep -q "root"; then
  sudo snapper -c root create-config /
fi
if ! sudo snapper list-configs 2>/dev/null | grep -q "home"; then
  sudo snapper -c home create-config /home
fi

sudo btrfs quota enable /

## Disable hourly snapshots
sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/{root,home}
## Change max snapshots to 5
sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="5"/' /etc/snapper/configs/{root,home}

sudo systemctl enable limine-snapper-sync
sudo limine-snapper-sync

# Remove other archinstall limine entries
while IFS= read -r bootnum; do
  sudo efibootmgr -b "$bootnum" -B >/dev/null 2>&1
done < <(efibootmgr | grep -E "^Boot[0-9A-F]{4}\*? Arch Linux Limine" | sed 's/^Boot\([0-9A-F]\{4\}\).*/\1/')
sudo rm -rf /boot/EFI/arch-limine 2>/dev/null || true
sudo rm -rf /boot/limine 2>/dev/null || true

# Remove mkinitcpio
paru -Rns --noconfirm $(paru -Qq | grep mkinitcpio)
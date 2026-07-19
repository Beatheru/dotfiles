sudo cp "$INSTALL_CONFIGS/limine/default.conf" /etc/default/limine
sudo cp "$INSTALL_CONFIGS/limine/limine.conf" /boot
sudo mkdir -p /etc/pacman.d/hooks
sudo cp "$INSTALL_CONFFIGS/limine/99-limine.hook /etc/pacman.d/hooks
KERNEL_PARAMS=$(cat /etc/kernel/cmdline)
sudo sed -i -E "s|^KERNEL_CMDLINE\[default\]\+=\"\"|KERNEL_CMDLINE[default]+=\"$KERNEL_PARAMS quiet splash\"|" /etc/default/limine

sudo limine-install
sudo limine-update

# Setup Snapper with Limine
if ! sudo snapper list-configs 2>/dev/null | grep -q "root"; then
  sudo snapper -c root create-config /
fi

if ! sudo snapper list-configs 2>/dev/null | grep -q "home"; then
  sudo snapper -c home create-config /home
fi

sudo btrfs quota enable /

log INFO "Modifying Snapper config"
## Disable hourly snapshots
sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/{root,home}
## Change max snapshots to 5
sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="5"/' /etc/snapper/configs/{root,home}

sudo systemctl enable --now limine-snapper-sync
sudo limine-snapper-sync

# Remove other archinstall limine entries
while IFS= read -r bootnum; do
  sudo efibootmgr -b "$bootnum" -B >/dev/null 2>&1
done < <(efibootmgr | grep -E "^Boot[0-9A-F]{4}\*? Arch Linux Limine" | sed 's/^Boot\([0-9A-F]\{4\}\).*/\1/')
sudo rm -rf /boot/EFI/arch-limine 2>/dev/null || true
sudo rm -rf /boot/limine 2>/dev/null || true

# Remove mkinitcpio
mkinitcpio_pkgs=$(paru -Qq | grep mkinitcpio || true)
if [[ -n "$mkinitcpio_pkgs" ]]; then
  paru -Rns --noconfirm "$mkinitcpio_pkgs"
fi

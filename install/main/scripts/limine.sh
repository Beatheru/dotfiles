#!/bin/bash

if [[ "$OS_ID" != "cachyos" ]]; then
  log INFO "Copying limine configs"
  sudo cp $INSTALL_CONFIGS/limine/default.conf /etc/default/limine
  sudo cp $INSTALL_CONFIGS/limine/limine.conf /boot
  log INFO "Adding kernel params"
  KERNEL_PARAMS=$(cat /etc/kernel/cmdline)
  sudo sed -i -E "s|^KERNEL_CMDLINE\[default\]\+=\"\"|KERNEL_CMDLINE[default]+=\"$KERNEL_PARAMS quiet splash\"|" /etc/default/limine

  log INFO "Running limine-install"
  sudo limine-install
  log INFO "Running limine-update"
  sudo limine-update

  # Setup Snapper with Limine
  log INFO "Creating snapper configs"
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
  ## Change max snapshots to 10
  sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="10"/' /etc/snapper/configs/{root,home}
  sudo sed -i 's/^NUMBER_LIMIT_IMPORTANT="10"/NUMBER_LIMIT_IMPORTANT="10"/' /etc/snapper/configs/{root,home}
  ## Change max space usage to be 30%
  sudo sed -i 's/^SPACE_LIMIT="0.5"/SPACE_LIMIT="0.3"/' /etc/snapper/configs/{root,home}
  ## Enable UKI and fallback
  sudo sed -i '/^ENABLE_UKI=/d; /^ENABLE_LIMINE_FALLBACK=/d' /etc/default/limine

  log INFO "Enabling limine-snapper-sync service"
  sudo systemctl enable limine-snapper-sync.service
  sudo limine-snapper-sync

  # Remove other archinstall limine entries
  while IFS= read -r bootnum; do
    sudo efibootmgr -b "$bootnum" -B >/dev/null 2>&1
  done < <(efibootmgr | grep -E "^Boot[0-9A-F]{4}\*? Arch Linux Limine" | sed 's/^Boot\([0-9A-F]\{4\}\).*/\1/')
  rm -rf /boot/EFI/arch-limine 2>/dev/null || true
fi
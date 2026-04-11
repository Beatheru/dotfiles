#!/bin/bash

if [[ "$OS_ID" != "cachyos" ]]; then
  # Install Limine
  echo "Installing Limine"
  paru -S --noconfirm --needed limine limine-dracut-support limine-snapper-sync snapper btrfs-assistant
  echo "Copying limine-entry-tool.conf to /etc/default/limine"
  sudo cp /etc/limine-entry-tool.conf /etc/default/limine
  sudo cp $SRC_DIR/limine.conf /boot
  echo "Running limine-install"
  sudo limine-install
  echo "Running limine-update"
  sudo limine-update

  # Setup Snapper with Limine
  echo "Creating snapper configs"
  sudo snapper -c root create-config /
  sudo snapper -c home create-config /home

  echo "Modifying Snapper config"
  ## Disable hourly snapshots
  sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/{root,home}
  ## Change max snapshots to 10
  sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="10"/' /etc/snapper/configs/{root,home}
  sudo sed -i 's/^NUMBER_LIMIT_IMPORTANT="10"/NUMBER_LIMIT_IMPORTANT="10"/' /etc/snapper/configs/{root,home}
  echo "MAX_SNAPSHOT_ENTRIES=10" | sudo tee -a /etc/default/limine
  ## Change max space usage to be 30%
  sudo sed -i 's/^SPACE_LIMIT="0.5"/SPACE_LIMIT="0.3"/' /etc/snapper/configs/{root,home}
  ## Enable UKI and fallback
  sudo sed -i '/^ENABLE_UKI=/d; /^ENABLE_LIMINE_FALLBACK=/d' /etc/default/limine

  echo "Enabling limine-snapper-sync service"
  sudo systemctl enable limine-snapper-sync.service
  sudo limine-snapper-sync
fi
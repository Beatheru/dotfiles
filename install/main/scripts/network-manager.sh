#!/bin/bash 

if [[ "$OS_ID" = "arch" ]]; then
  # Install NetworkManager
  log INFO "Installing NetworkManager"
  paru -S --noconfirm --needed networkmanager iwd

  # Use iwd as a backend
  log INFO "Configuring iwd as NetworkManager backend"
  sudo systemctl disable iwd
  cat <<EOF | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
[device]
wifi.backend=iwd
EOF

  # Enable NetworkManager
  log INFO "Enabling NetworkManager"
  sudo systemctl enable NetworkManager
fi
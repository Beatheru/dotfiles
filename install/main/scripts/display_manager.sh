#!/bin/bash

if [[ "$OS_ID" = "cachyos" ]]; then
  sudo mkdir -p /etc/sddm.conf.d
  cat <<EOF | sudo tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=niri
EOF
else 
  # Install Ly display manager
  log INFO "Installing Ly"
  paru -S --noconfirm --needed ly
  log INFO "Disabling getty service"
  sudo systemctl disable getty@tty1.service
  log INFO "Enabling ly service"
  sudo systemctl enable ly@tty1.service

  log INFO "Configuring Ly autologin"
  cat <<EOF | sudo tee /etc/ly/config.ini
auto_login_session = niri
auto_login_user = $USER
EOF
fi
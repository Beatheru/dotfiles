#!/bin/bash 

# Enable bluetooth
if service_exists bluetooth.service; then
  log INFO "Enabling Bluetooth service"
  sudo systemctl enable bluetooth.service
else
  log ERROR "Bluetooth service does not exist"
fi
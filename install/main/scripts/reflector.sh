#!/bin/bash 

# Enable Reflector
if service_exists reflector.timer; then
  log INFO "Enabling Reflector"
  sudo systemctl enable reflector.timer
fi
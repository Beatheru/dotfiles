#!/bin/bash

# Check if mirrorlist exists and contains a comment indicating reflector setup
# Skip reflector setup if it already ran
if [[ -f /etc/pacman.d/mirrorlist ]] && grep -q "^#.*Reflector" /etc/pacman.d/mirrorlist; then
  log INFO "Skipping reflector setup"

else
  # Run Reflector
  log INFO "Installing reflector"
  sudo pacman -S --noconfirm --needed reflector
  log INFO "Running reflector"
  sudo reflector --verbose --protocol https --latest 10 --sort rate --fastest 5 --save /etc/pacman.d/mirrorlist
fi


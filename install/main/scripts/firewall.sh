#!/bin/bash

if systemctl is-active --quiet ufw; then
  log INFO "UFW is already active, skipping firewall setup"
else
  log INFO "Setting up UFW firewall"
  
  # Allow nothing in, everything out
  sudo ufw default deny incoming
  sudo ufw default allow outgoing

  # Allow ports for LocalSend
  sudo ufw allow 53317/udp
  sudo ufw allow 53317/tcp

  # Allow Docker containers to use DNS on host
  sudo ufw allow in proto udp from 172.16.0.0/12 to 172.17.0.1 port 53 comment 'allow-docker-dns'

  # Turn on the firewall
  sudo ufw --force enable

  # Enable UFW systemd service to start on boot
  sudo systemctl enable ufw

  # Turn on Docker protections
  sudo ufw-docker install
  sudo ufw reload
fi



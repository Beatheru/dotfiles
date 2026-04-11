#!/bin/bash

# Enable Docker
log INFO "Enabling docker"
sudo systemctl enable docker

log INFO "Adding user to docker group"
sudo usermod -aG docker ${USER}
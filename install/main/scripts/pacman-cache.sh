#!/bin/bash

log INFO "Enabling paccache.timer service"
sudo systemctl enable paccache.timer

sudo sed -i -E "s|^PACCACHE_ARGS=|PACCACHE_ARGS=\"-k1\"|" /etc/conf.d/pacman-contrib
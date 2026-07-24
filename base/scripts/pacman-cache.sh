sudo systemctl enable paccache.timer

# Keep one version of the package
sudo sed -i -E "s|^PACCACHE_ARGS=|PACCACHE_ARGS=\"-k1\"|" /etc/conf.d/pacman-contrib
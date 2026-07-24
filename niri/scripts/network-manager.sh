# Use iwd as a backend
# sudo systemctl disable iwd
# cat <<EOF | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
# [device]
# wifi.backend=iwd
# EOF

# sudo systemctl enable NetworkManager
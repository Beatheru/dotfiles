# Use iwd as a backend
log INFO "Configuring iwd as NetworkManager backend"
sudo systemctl disable iwd
cat <<EOF | sudo tee /etc/NetworkManager/conf.d/wifi_backend.conf
[device]
wifi.backend=iwd
EOF

activate NetworkManager
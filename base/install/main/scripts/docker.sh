sudo systemctl enable --now docker

# Add user to docker group if it isn't a part of it
if ! id -nG "$USER" | grep -qw "docker"; then
  sudo usermod -aG docker "$USER"
fi

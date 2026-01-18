activate docker

# Add user to docker group if it isn't a part of it
if ! id -nG "$USER" | grep -qw "docker"; then
  log INFO "Adding user to docker group"
  sudo usermod -aG docker "$USER"
fi
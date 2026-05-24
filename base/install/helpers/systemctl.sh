exists() {
  systemctl list-unit-files "$1" &>/dev/null
}

activate() {
  if ! exists "$1"; then
    log ERROR "$1 service does not exist"

    return 1
  fi

  sudo systemctl enable --now "$1"
}

export -f activate

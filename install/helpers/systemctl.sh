exists() {
  systemctl list-unit-files | grep -q "^$1[[:space:]]"
}

is_enabled() {
  systemctl is-enabled --quiet "$1"
}

is_active() {
  systemctl is-active --quiet "$1"
}

activate() {
  if ! exists "$1"; then
    log ERROR "$1 service does not exist"

    return 1
  fi

  if ! is_enabled "$1"; then
    log INFO "Enabling $1"
    if ! sudo systemctl enable "$1"; then
      log ERROR "Failed to enable $1"

      return 1
    fi
  fi

  if ! is_active "$1"; then
    log INFO "Starting $1"
    if ! sudo systemctl start "$1"; then
      log ERROR "Failed to start $1"
      
      return 1
    fi
  fi
}

export -f activate
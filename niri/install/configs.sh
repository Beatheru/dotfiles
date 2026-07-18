log INFO "Symlinking niri configs with stow"
stow -d "$INSTALL_CONFIGS" -t ~ --no-folding niri noctalia

# ---------- 1. Install packages ---------- #

mapfile -t packages < <(grep -v '^#' "$INSTALL_SCRIPTS/packages.list" | grep -v '^$')
paru -S --noconfirm --needed "${packages[@]}"

# ---------- 2. Setup config files ---------- #

link_config "$INSTALL_CONFIGS/niri" ".config/niri"

# ---------- 3. Run misc scripts ---------- #

for file in "$INSTALL_SCRIPTS/scripts/"*; do
  if [[ -f "$file" && "$file" == *.sh ]]; then
    log INFO "Running $(basename "$file")"
    source "$file"
  fi
done
# ---------- 1. Configure Reflector ---------- #

sudo pacman -S --noconfirm --needed reflector
sudo systemctl enable reflector.timer
sudo reflector --verbose --protocol https --latest 10 --sort rate --fastest 5 --save /etc/pacman.d/mirrorlist

# ---------- 2. Install Paru ---------- #

if ! command -v paru &>/dev/null; then
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (cd /tmp/paru && makepkg -si --noconfirm)
  rm -rf /tmp/paru
fi

# ---------- 3. Install packages ---------- #

sudo sed -i 's/^#Color$/Color/' /etc/pacman.conf
sudo sed -i 's/^#ILoveCandy$/ILoveCandy/' /etc/pacman.conf
sudo sed -i 's/^#VerbosePkgLists$/VerbosePkgLists/' /etc/pacman.conf
sudo sed -i 's/^#DownloadUser = alpm$/DownloadUser = alpm/' /etc/pacman.conf

mapfile -t packages < <(grep -v '^#' "$INSTALL_SCRIPTS/packages.list" | grep -v '^$')
paru -S --noconfirm --needed "${packages[@]}"

# ---------- 4. Setup config files ---------- #

link_config "$INSTALL_CONFIGS/bash" ""
link_config "$INSTALL_CONFIGS/fastfetch" ".config/fastfetch"
link_config "$INSTALL_CONFIGS/ghostty" ".config/ghostty"

# ---------- 5. Run misc scripts ---------- #

for file in "$INSTALL_SCRIPTS/scripts/"*; do
  if [[ -f "$file" && "$file" == *.sh ]]; then
    log INFO "Running $(basename "$file")"
    source "$file"
  fi
done
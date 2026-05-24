log INFO "Updating system"
sudo pacman -Syu --noconfirm

log INFO "Installing Paru"
sudo pacman -S --noconfirm --needed base-devel
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (cd /tmp/paru && makepkg -si --noconfirm)
  rm -rf /tmp/paru
fi
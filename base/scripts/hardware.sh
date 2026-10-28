# Hardware acceleration for Intel GPU
if has_intel; then
  paru -S --noconfirm --needed intel-media-driver vulkan-intel linux-firmware-intel
fi

if has_nvidia; then
  kernel=$(pacman -Qqs '^linux(-zen|-lts|-hardened)?$' | head -1)
  paru -S --noconfirm --needed nvidia-open-dkms "${kernel}-headers" nvidia-utils lib32-nvidia-utils libva-nvidia-driver nvidia-prime nvidia-settings
fi

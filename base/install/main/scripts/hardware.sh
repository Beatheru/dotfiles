# Hardware acceleration for Intel GPU
if has_intel; then
  paru -S --noconfirm --needed intel-media-driver
fi

if has_nvidia; then
  paru -S --noconfirm --needed nvidia-open nvidia-utils lib32-nvidia-utils libva-nvidia-driver nvidia-prime nvidia-settings opencl-nvidia lib32-opencl-nvidia
fi
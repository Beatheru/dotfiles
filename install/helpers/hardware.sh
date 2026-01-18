has_intel() {
  lspci | grep -iE 'vga|3d|display' | grep -qi 'intel'
}

has_nvidia() {
  lspci | grep -iE 'vga|3d|display' | grep -qi 'nvidia'
}

export -f has_intel has_nvidia
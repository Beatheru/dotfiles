# Clone cursor tail shaders
DIR="$HOME/.config/ghostty/shaders"
if [[ ! -d "$DIR" ]]; then
  git clone https://github.com/sahaj-b/ghostty-cursor-shaders "$DIR"
fi
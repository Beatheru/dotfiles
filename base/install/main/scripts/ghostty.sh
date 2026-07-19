# Clone cursor tail shaders
DIR="$HOME/.config/ghostty/shaders"
if [[ ! -d "$DIR" ]]; then
  git clone --depth 1 https://github.com/sahaj-b/ghostty-cursor-shaders "$DIR"
fi
link_config() {
  local dir="$1" prefix="$2"
  find "$dir" -type f | while read -r f; do
    local target="$HOME/$prefix/${f#"$dir/"}"
    mkdir -p "$(dirname "$target")"
    ln -sf "$f" "$target"
  done
}

export -f link_config
source "$INSTALL_SCRIPTS/packages.sh"

# Run all script files
for file in "$INSTALL_SCRIPTS/scripts/"*; do
  if [[ -f "$file" && "$file" == *.sh ]]; then
    log INFO "Running $file"
    source "$file"
    log SUCCESS "Finished $file"
  fi
done
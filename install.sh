#!/bin/bash

set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Do not run this script as root or with sudo."
  exit 1
fi

sudo pacman -Syu --noconfirm

export INSTALL_HOME="$(cd "$(dirname "$0")" && pwd)"
export INSTALL_CONFIGS="$INSTALL_HOME/base/configs"
export INSTALL_SCRIPTS="$INSTALL_HOME/base"

source "$INSTALL_HOME/lib/all.sh"

start=$(date +%s)

source "$INSTALL_SCRIPTS/base.sh"

export INSTALL_CONFIGS="$INSTALL_HOME/niri/configs"
export INSTALL_SCRIPTS="$INSTALL_HOME/niri"

source "$INSTALL_HOME/niri/niri.sh"

end=$(date +%s)
elapsed=$((end - start))

minutes=$((elapsed / 60))
seconds=$((elapsed % 60))

log SUCCESS "Finished in ${minutes}m ${seconds}s"
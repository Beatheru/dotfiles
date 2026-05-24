#!/bin/bash

set -euo pipefail

trap 'log ERROR "Script failed at line $LINENO"' ERR

export INSTALL_HOME="$(cd "$(dirname "$0")" && pwd)"
export INSTALL_CONFIGS="$INSTALL_HOME/base/configs"
export INSTALL_SCRIPTS="$INSTALL_HOME/base/install"

start=$(date +%s)

source "$INSTALL_SCRIPTS/helpers/all.sh"
source "$INSTALL_SCRIPTS/setup/all.sh"
source "$INSTALL_SCRIPTS/main/all.sh"

if [[ -n "${1:-}" ]]; then
  if [[ ! -d "$INSTALL_HOME/$1" ]]; then
    log ERROR "Unknown environment: $1"
    exit 1
  fi

  export INSTALL_CONFIGS="$INSTALL_HOME/$1/configs"
  export INSTALL_SCRIPTS="$INSTALL_HOME/$1/install"

  source "$INSTALL_HOME/$1/install/all.sh"
fi

end=$(date +%s)
elapsed=$((end - start))

minutes=$((elapsed / 60))
seconds=$((elapsed % 60))

if (( minutes > 0 )); then
  log SUCCESS "Finished in ${minutes}m ${seconds}s"
else
  log SUCCESS "Finished in ${seconds}s"
fi
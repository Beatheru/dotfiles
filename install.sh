#!/bin/bash

set -euo pipefail

export OS_ID=$(awk -F= '/^ID/{print $2}' /etc/os-release | tr -d '"')

export INSTALL_HOME="$PWD"
export INSTALL_CONFIGS="$INSTALL_HOME/configs"
export INSTALL_SCRIPTS="$INSTALL_HOME/install"

start=$(date +%s)

source $INSTALL_SCRIPTS/helpers/all.sh
source $INSTALL_SCRIPTS/setup/all.sh
source $INSTALL_SCRIPTS/main/all.sh

end=$(date +%s)
elapsed=$((end - start))

minutes=$((elapsed / 60))
seconds=$((elapsed % 60))

if (( minutes > 0 )); then
  log SUCCESS "Finished in ${minutes}m ${seconds}s"
else
  log SUCCESS "Finished in ${seconds}s"
fi
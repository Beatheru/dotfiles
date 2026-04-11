#!/bin/bash

# Copy configs
log INFO "Copying configs to .config"
mkdir -p ~/.config
cp -R $INSTALL_CONFIGS/.config/* ~/.config/
cp -f $INSTALL_CONFIGS/bash/bashrc ~/.bashrc
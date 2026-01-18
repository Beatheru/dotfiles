# Copy configs
log INFO "Copying configs to .config"
mkdir -p ~/.config
cp -R $INSTALL_CONFIGS/.config/* ~/.config/
cp -f $INSTALL_CONFIGS/bash/bashrc ~/.bashrc
sudo cp -f $INSTALL_CONFIGS/pacman/pacman.conf /etc/pacman.conf
KERNEL_PARAMS=$(cat /etc/kernel/cmdline)
sudo sed -i -E "s|^KERNEL_CMDLINE\[default\]\+=\"\"|KERNEL_CMDLINE[default]+=\"$KERNEL_PARAMS quiet splash\"|" /etc/default/limine
sudo cp -r "$INSTALL_CONFIGS/plymouth/arch-mac-style" /usr/share/plymouth/themes/
sudo plymouth-set-default-theme arch-mac-style
sudo limine-update
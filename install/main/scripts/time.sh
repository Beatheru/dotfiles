#!/bin/bash 

# Stop time conflict with Windows dual boot
log INFO "Removing Unix UTC time conflict with Windows"
sudo timedatectl --no-ask-password set-local-rtc 1
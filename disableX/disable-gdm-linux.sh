#!/usr/bin/env bash

#check for sudo (root)
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

echo "stopping gdm..."
systemctl stop gdm

echo "Disabling gdm..."
systemctl disable gdm

echo "Removing GDM.."
apt remove --purge -y gdm3
apt autoremove -y

echo "GDM has been remove. you will need another display manager or can log in via tty."

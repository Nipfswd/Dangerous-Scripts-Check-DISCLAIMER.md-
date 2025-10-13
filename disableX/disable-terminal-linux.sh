#!/bin/bash

# Check for root priv
if [[ $EUID -ne 0 ]]; then
    echo "X This script must be run as root."
    exit 1
fi 

#if usernanme is passed as argument, use it; otherwise prompt
if [[ -z "$1" ]]; then 
read -p "Enter the username to disable shell for: " USERNAME
else
    USERNAME="$1"
fi

#validate user
if ! id "$USERNAME" &>/dev/null; then
    echo "X User '$USERNAME' does not exist."
    exit 1
fi 

#show current shell
CURRENT_SHELL=$(getent passwd "$USERNAME" | cut -d: -f7)
echo "Current shell for '$USERNAME': $CURRENT_SHELL"

#confirm action
read -p "This will disable the shell access for '$USERNAME'. Type 'YES' to proceed: " CONFIRM
if [[ "$CONFIRM" != "YES" ]]; then 
    echo "X Aborted"
    exit 1
fi 

#disable shell
usermod -s /usr/sbin/nologin "$USERNAME"
echo "Now your terminal is gone! Enable it by watching tutorial because im to lazy to tell you, '$USERNAME'"


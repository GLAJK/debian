#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "  Installing Debian KDE Minimal Desktop   "
echo "=========================================="

echo " -> Updating package lists "
apt update

echo " -> Installing core KDE applications "
apt install -y \
  konsole \
  dolphin \
  dolphin-plugins \
  sddm \
  plasma-desktop

echo "------------------------------------------"
echo "         Minimalist Bloat Removal         "
echo "------------------------------------------"

# Array to hold packages we want to remove
PURGE_PACKAGES=()

# Ask to remove Plasma Discover
echo -n "Remove 'plasma-discover' (Force terminal-only package management)? [y/N]: "
read -r resp_discover
if [[ "$resp_discover" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  PURGE_PACKAGES+=(plasma-discover plasma-discover-common)
fi

# Ask to remove KHelpCenter
echo -n "Remove 'khelpcenter' (KDE Help Documentation)? [y/N]: "
read -r resp_help
if [[ "$resp_help" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  PURGE_PACKAGES+=(khelpcenter)
fi

# Ask to remove Plasma Welcome
echo -n "Remove 'plasma-welcome' (Welcome wizard)? [y/N]: "
read -r resp_welcome
if [[ "$resp_welcome" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  PURGE_PACKAGES+=(plasma-welcome)
fi

# Ask to remove KDE Connect
echo -n "Remove 'kdeconnect' (Phone integration tool)? [y/N]: "
read -r resp_kdeconnect
if [[ "$resp_kdeconnect" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  PURGE_PACKAGES+=(kdeconnect)
fi

# Execute purge if the user selected any packages
if [ ${#PURGE_PACKAGES[@]} -gt 0 ]; then
  echo " -> Purging selected packages "
  # || true ensures the script keeps running even if a package wasn't fully installed yet
  apt purge -y "${PURGE_PACKAGES[@]}" || true
fi

# Ask to auto-remove / autopurge unused leftover dependencies
echo -n "Run 'apt autopurge' to clean up orphaned packages? [y/N]: "
read -r resp_purge
if [[ "$resp_purge" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo " -> Cleaning up unused packages "
  apt autopurge -y
fi

echo "------------------------------------------"
echo "        Configuring System Services        "
echo "------------------------------------------"

echo " -> Enabling SDDM display manager "
systemctl enable sddm

echo "=========================================="
echo "        KDE Minimal Setup Completed!      "
echo "=========================================="

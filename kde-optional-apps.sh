#!/usr/bin/env bash

# Exit immediately on errors or unset variables
set -euo pipefail

# Ensure the script is run with root/sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "   Installing Optional KDE Applications   "
echo "=========================================="

# Array to hold packages selected for installation
CHOSEN_PACKAGES=()

echo " -> Please select which applications you want to install:"

# 1. Ark (Archiver)
echo -n "Install 'ark' (Archive manager / zip & tar tool)? [y/N]: "
read -r resp_ark
if [[ "$resp_ark" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(ark)
fi

# 2. Filelight (Disk Usage)
echo -n "Install 'filelight' (Disk space usage visualizer)? [y/N]: "
read -r resp_filelight
if [[ "$resp_filelight" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(filelight)
fi

# 3. ISO Image Writer
echo -n "Install 'isoimagewriter' (USB bootable image flasher)? [y/N]: "
read -r resp_iso
if [[ "$resp_iso" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(isoimagewriter)
fi

# 4. Kate (Advanced Text Editor)
echo -n "Install 'kate' (Advanced text editor / lightweight IDE)? [y/N]: "
read -r resp_kate
if [[ "$resp_kate" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(kate)
fi

# 5. Dragon Player (Video Player)
echo -n "Install 'dragonplayer' (Simple, lightweight video player)? [y/N]: "
read -r resp_dragon
if [[ "$resp_dragon" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(dragonplayer)
fi

# 6. Elisa (Music Player)
echo -n "Install 'elisa' (Modern music player)? [y/N]: "
read -r resp_elisa
if [[ "$resp_elisa" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(elisa)
fi

# 7. Gwenview (Image Viewer)
echo -n "Install 'gwenview' (Feature-rich image viewer)? [y/N]: "
read -r resp_gwenview
if [[ "$resp_gwenview" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(gwenview)
fi

# 8. Okular (Document Viewer)
echo -n "Install 'okular' (PDF and document viewer)? [y/N]: "
read -r resp_okular
if [[ "$resp_okular" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(okular)
fi

# 9. Partition Manager
echo -n "Install 'partitionmanager' (KDE disk partition utility)? [y/N]: "
read -r resp_partition
if [[ "$resp_partition" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CHOSEN_PACKAGES+=(partitionmanager)
fi

echo "---------------------------------------------------------"

# Execute installation if any packages were chosen
if [ ${#CHOSEN_PACKAGES[@]} -gt 0 ]; then
  echo " -> Updating package lists "
  apt update

  echo " -> Installing selected applications "
  # Using --no-install-recommends to keep the optional apps bloated-free
  apt install -y --no-install-recommends "${CHOSEN_PACKAGES[@]}"

  echo "=========================================="
  echo "   Applications Installed Successfully!   "
  echo "=========================================="
else
  echo " -> No applications selected. Skipping installation "
fi

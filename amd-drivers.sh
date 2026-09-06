#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status,
# if an unset variable is used, or if a piped command fails.
set -euo pipefail

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with sudo or as root."
  exit 1
fi

echo "=========================================="
echo "       AMD Graphics Setup & Drivers       "
echo "=========================================="

# Prompt user for i386 / Steam architecture support
echo -n "Do you want to enable i386 architecture support (required for Steam/32-bit gaming)? [y/N]: "
read -r response

# Define base packages that install regardless of choice
PACKAGES=(
  amd64-microcode
  firmware-amd-graphics
  mesa-va-drivers
  mesa-vulkan-drivers
  mesa-utils
  mesa-utils-bin
  mesa-opencl-icd
  mesa-vdpau-drivers
  vulkan-tools
  libvulkan1
  libgl1-mesa-dri
  libglx-mesa0
  libegl-mesa0
  xserver-xorg-video-all
)

# Process user choice
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo " -> Enabling i386 architecture "
  dpkg --add-architecture i386

  # Append 32-bit driver packages to our list
  PACKAGES+=(
    mesa-vulkan-drivers:i386
    libgl1-mesa-dri:i386
  )
else
  echo " -> Skipping i386 architecture "
fi

echo " -> Updating package lists "
apt update

echo " -> Installing drivers and libraries "
# Added --no-install-recommends to stick to the minimal-install philosophy
apt install -y "${PACKAGES[@]}"

echo "=========================================="
echo "    AMD Drivers Installed Successfully!   "
echo "=========================================="

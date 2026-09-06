# Debian KDE Minimal Install

Lightweight, debloated Debian KDE Plasma setup scripts optimized specifically for AMD systems. Get a fast, modern desktop without the pre-installed software suite.

## Features
* Interactive Control: Choose what to install or remove via terminal prompts.
* True Minimal KDE: Installs only the bare essentials (kde-plasma-desktop) without games, office suites, or bloat.
* AMD Optimized: Configures modern AMD GPU firmware and Vulkan drivers.

## Prerequisites
* A fresh, bootable Debian Netinstall (Standard System Utilities only, no desktop environment selected during install).
* An AMD CPU/GPU hardware configuration.
* An active internet connection.

## Scripts
* amd-drivers.sh | Sets up AMD GPU drivers and media libraries. | Enable i386 (32-bit) architecture for Steam gaming.
* kde-minimal-install.sh | Installs base Plasma desktop environment. | Purge minimal bloat (plasma-discover, kdeconnect, khelpcenter).
* kde-optional-apps.sh | Installs optional native KDE utilities. | Choose to add tools like kate, ark, okular, or gwenview.

## How to Use

### 1. Clone the repository
Boot into your minimal Debian environment and run:
```bash
sudo apt update && sudo apt install git -y
git clone https://github.com/GLAJK/debian.git
cd debian
```

### 2. Run the Scripts in Order
Make sure the scripts are executable and run them using sudo:

1. Install amd drivers:
```bash
sudo ./amd-drivers.sh
```

2. Install desktop environment:
```bash
sudo ./kde-minimal-install.sh
```
3. Install Core Utilities (Optional):
```bash
sudo ./kde-optional-apps.sh
```
## Important Note for Wi-Fi Users

If you are using Wi-Fi, you must hand over network management to NetworkManager before rebooting. Otherwise, the KDE Plasma system tray network applet (plasma-nm) will show your device as unmanaged or disconnected.

### 1. Enable managed mode
Open the NetworkManager configuration file:
```bash
sudo nano /etc/NetworkManager/NetworkManager.conf
```
Find the line managed=false and change it to:
```bash
managed=true
```
Save and close the file (Ctrl+O, Enter, Ctrl+X).

### 2. Comment out primary interfaces
To prevent conflicts, open the legacy network interfaces file:
```bash
sudo nano /etc/network/interfaces
```
Add a # symbol to the beginning of every line underneath the # The primary network interface comment section.
Save and close the file.

### 3. Reboot
Once everything is completed, safely reboot your system to enter your clean, minimal KDE Plasma environment:
```bash
sudo reboot
```

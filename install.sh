#!/bin/bash

# Check if the OS is Arch-based
if ! command -v pacman &> /dev/null
then
    echo "This script is designed for Arch-based distributions. Exiting."
    exit 1
fi

# ASCII Art Banner
echo "======================================"
echo " _______           _        ______    "
echo "(       )|\\     /|( \\      (  __  \\  "
echo "| () () || )   ( || (      | (  \\  ) "
echo "| || || || (___) || |      | |   ) | "
echo "| |(_)| ||  ___  || |      | |   | | "
echo "| |   | || (   ) || |      | |   ) | "
echo "| )   ( || )   ( || (____/\\| (__/  ) "
echo "|/     \\||/     \\|(_______/(______/  "
echo "                                      "
echo "        Installing MHLD Setup         "
echo "======================================"
sleep 2

# Install Bun
curl -fsSL https://bun.sh/install | bash && sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun

# Required dependencies
echo "Installing required dependencies..."
sudo pacman -Suy aylurs-gtk-shell networkmanager gnome-bluetooth-3.0 pipewire libgtop bluez bluez-utils wl-clipboard dart-sass brightnessctl || exit 1

# Optional packages
echo "Installing optional packages..."
sudo pacman -S python python-gpustat pywal pacman-contrib power-profiles-daemon grimblast gpu-screen-recorder hyprpicker btop matugen swww || exit 1

# Install ags via yay
echo "Installing ags with yay..."
yay -S ags || exit 1

# Backup existing ags config if it exists
if [ -d "$HOME/.config/ags" ]; then
    echo "Backing up existing ags configuration..."
    mv "$HOME/.config/ags" "$HOME/.config/ags.bkup"
fi

# Clone MHLD and install fonts
echo "Cloning MHLD repository..."
git clone https://github.com/Jas-SinghFSU/HyprPanel.git || exit 1
echo "Installing fonts..."
./HyprPanel/install_fonts.sh

# Install rofi if not already installed
echo "Installing rofi..."
sudo pacman -S rofi || exit 1

# Link MHLD config to ~/.config/ags
echo "Setting up MHLD configuration..."
ln -s "$(pwd)/HyprPanel" "$HOME/.config/ags"

# Backup and replace hyprland.conf
if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
    echo "Backing up existing hyprland.conf..."
    cp "$HOME/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland_backup.conf"
fi
cp .config/hypr/hyprland.conf "$HOME/.config/hypr/hyprland.conf"

# Copy wallpapers to home directory
echo "Copying wallpapers..."
cp -r wallpapers "$HOME/"

# Backup and replace rofi config
if [ -f "$HOME/.config/rofi/config.rasi" ]; then
    echo "Backing up existing rofi config..."
    cp "$HOME/.config/rofi/config.rasi" "$HOME/.config/rofi/config_backup.rasi"
fi
cp .config/rofi/config.rasi "$HOME/.config/rofi/config.rasi"

# Copy rofi themes
echo "Copying rofi themes..."
cp -r .local/share/rofi/themes/ "$HOME/.local/share/rofi/themes/"

echo "======================================"
echo "       MHLD Setup Complete! Enjoy!    "
echo "======================================"

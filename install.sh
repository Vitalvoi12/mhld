#!/bin/bash

# Install Bun
curl -fsSL https://bun.sh/install | bash && sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun

# Required dependencies
sudo pacman -Suy aylurs-gtk-shell networkmanager gnome-bluetooth-3.0 pipewire libgtop bluez bluez-utils wl-clipboard dart-sass brightnessctl || exit 1

# Optional packages
sudo pacman -S python python-gpustat pywal pacman-contrib power-profiles-daemon grimblast gpu-screen-recorder hyprpicker btop matugen swww || exit 1

# Install ags via yay
yay -S ags || exit 1

# Backup existing ags config if it exists
[ -d "$HOME/.config/ags" ] && mv "$HOME/.config/ags" "$HOME/.config/ags.bkup"

# Clone HyprPanel and install fonts
git clone https://github.com/Jas-SinghFSU/HyprPanel.git || exit 1
./HyprPanel/install_fonts.sh

# Install rofi if not already installed
sudo pacman -S rofi || exit 1

# Link HyprPanel config to ~/.config/ags
ln -s "$(pwd)/HyprPanel" "$HOME/.config/ags"

# Backup and replace hyprland.conf
[ -f "$HOME/.config/hypr/hyprland.conf" ] && cp "$HOME/.config/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland_backup.conf"
cp .config/hypr/hyprland.conf "$HOME/.config/hypr/hyprland.conf"

# Copy wallpapers to home directory
cp -r wallpapers "$HOME/"

# Backup and replace rofi config
[ -f "$HOME/.config/rofi/config.rasi" ] && cp "$HOME/.config/rofi/config.rasi" "$HOME/.config/rofi/config_backup.rasi"
cp .config/rofi/config.rasi "$HOME/.config/rofi/config.rasi"

# Copy rofi themes
cp -r .local/share/rofi/themes/ "$HOME/.local/share/rofi/themes/"

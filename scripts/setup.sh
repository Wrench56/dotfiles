#!/bin/sh

# Post install script for Arch Linux

# shellcheck disable=SC2312

# Enable pacman parallel downloads
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

# Weekly pacman cache clearing
sudo pacman -Sy --noconfirm pacman-contrib
sudo systemctl enable paccache.timer

# Get some frequently used packages
sudo pacman -S --noconfirm neofetch onefetch tokei htop git nano man-db exa wget bc unzip gdu speedtest-cli ripgrep
git config --global credential.helper store

# Get GitHub CLI
sudo pacman -S --noconfirm github-cli

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S --noconfirm i3 xorg-server xorg-xinit i3blocks

# Get rofi
sudo pacman -S --noconfirm rofi
sudo pacman -S --noconfirm papirus-icon-theme

# Fix boot messages disappearing
sudo sed -i s/TTYVTDisallocate=yes/TTYVTDisallocate=no/ /etc/systemd/system/getty.target.wants/getty@tty1.service 
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub

# Hide the GRUB boot menu
sudo sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub

# Run mkconfig for GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Create user specific systemd service/timer directory
mkdir ~/.config/systemd ~/.config/systemd/user

# Configure bluetooth
sudo pacman -S --noconfirm bluez bluez-utils pulseaudio-bluetooth
# Enable btusb module if not already loaded
if [ "$(lsmod | grep -c "^btusb")" -eq 0 ]; then modprobe btusb; fi
sudo systemctl enable bluetooth.service
sudo systemctl --user enable pulseaudio

# Clone the dotfiles GitHub repository
git clone https://github.com/Wrench56/dotfiles

# Make the dotfiles scripts executable
rm ./dotfiles/scripts/setup.sh
for file in ./dotfiles/scripts/*
do
    chmod +x "$file"
done

# Download dunst
sudo pacman -S --noconfirm dunst libnotify

# Make ~/.local/bin directory
mkdir -p ~/.local/bin
# Make ~/.local/share/fonts directory
mkdir -p ~/.local/share/fonts
# Make ~/.cache/bash directory
mkdir -p ~/.cache/bash
# Make ~/.config
mkdir -p ~/.config
# Make ~/.secrets
mkdir -p ~/.secrets


##########################################
################ LANGUAGES ###############
##########################################

# Install Python
sudo pacman -S --noconfirm python python-pip

# Install Rust
sudo pacman -S --noconfirm rustup
rustup default stable
rustup component add rust-analyzer

# Install clang & gdb (debugger)
sudo pacman -S --noconfirm clang gdb

# Install Node.js
sudo pacman -S --noconfirm nodejs npm


##########################################
################## APPS ##################
##########################################

# Get alacritty terminal emulator
sudo pacman -S --noconfirm alacritty
    # Download lightweight clipboard
    sudo pacman -S --noconfirm xclip
    # Install hack nerd fonts
    sudo pacman -S --noconfirm ttf-hack-nerd
    # Install xdg-utils (xdg-open)
    sudo pacman -S --noconfirm xdg-utils

# Download neovim
sudo pacman -S --noconfirm neovim
    # Install lazygit
    sudo pacman -S --noconfirm lazygit
    # Install jq & tidy (for rest.nvim)
    sudo pacman -S --noconfirm jq tidy
    # Install pynvim
    pip install pynvim


# Download Qutebrowser
sudo pacman -S --noconfirm qutebrowser

# Download maim (snipping tool)
sudo pacman -S --noconfirm maim xdotool

# System update
sudo pacman -Syu --noconfirm

# Run dotfiles.sh script
sleep 1
cd dotfiles || exit 1
./scripts/dotfiles.sh


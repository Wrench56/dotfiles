#!/bin/bash

# Post install script for Arch Linux

# Enable pacman parallel downloads
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

# Weekly pacman cache clearing
sudo pacman -Sy --noconfirm pacman-contrib
sudo systemctl enable paccache.timer

# Get some frequently used packages
sudo pacman -S --noconfirm neofetch htop git nano man-db exa

# Get yay AUR package helper
sudo pacman -S --needed --noconfirm git base-devel
sudo pacman -S --noconfirm go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Download downgrade
yay -S downgrade --noconfirm

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S --noconfirm i3 xorg dmenu i3status

# Fix boot messages disappearing
sudo sed -i s/TTYVTDisallocate=yes/TTYVTDisallocate=no/ /etc/systemd/system/getty.target.wants/getty@tty1.service 
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub

# Hide the GRUB boot menu
sudo sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub

# Run mkconfig for GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Set up display manager
# Use older versions where x_cmd is working (you can change --ala-only)
yes | sudo downgrade 'ly=0.5.3-5' --ala-only
sudo systemctl enable ly.service

# Clone the dotfiles GitHub repository
git clone https://github.com/Wrench56/dotfiles

# Make the dotfiles scripts executable
rm ./dotfiles/scripts/setup.sh
chmod +x ./dotfiles/scripts/dotfiles.sh
chmod +x ./dotfiles/scripts/maintenance.sh

# Download feh & set up wallpaper
sudo pacman -S --noconfirm feh
feh --bg-scale ./dotfiles/wallpaper.png

##########################################
################## APPS ##################
##########################################

# Get alacritty terminal emulator (I want a lightweight terminal with opaque background)
sudo pacman -S --noconfirm alacritty
    # Download lightweight clipboard
    sudo pacman -S --noconfirm xclip
    # Install hack nerd fonts
    sudo pacman -S --noconfirm ttf-hack-nerd

# Download brave browser (might change)
yay -S --noconfirm brave-bin

# Download neovim
sudo pacman -S --noconfirm neovim

# System update
sudo pacman -Syu --noconfirm
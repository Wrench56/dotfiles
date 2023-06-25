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

# Get alacritty terminal emulator (I want a lightweight terminal with opaque background)
sudo pacman -S --noconfirm alacritty

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S --noconfirm i3 xorg xorg-xdm dmenu i3status ttf-hack
echo "exec i3" > ~/.xsession
chmod +x ~/.xsession

# Enable X display manager
sudo systemctl enable xdm.service

# Fix boot messages disappearing
sudo sed -i s/TTYVTDisallocate=yes/TTYVTDisallocate=no/ /etc/systemd/system/getty.target.wants/getty@tty1.service 
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub

# Hide the GRUB boot menu
sudo sed -i "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub

# Run mkconfig for GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Clone the dotfiles GitHub repository
git clone https://github.com/Wrench56/dotfiles

# Download feh & set up wallpaper
sudo pacman -S --noconfirm feh
feh --bg-scale dotfiles/wallpaper.png

##########################################
################## APPS ##################
##########################################

# Download brave browser (might change)
yay -S brave-bin --noconfirm

# Download neovim
sudo pacman -S --noconfirm neovim

# System update
sudo pacman -Syu
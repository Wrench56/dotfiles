#!/bin/sh

# Post install script for Arch Linux

# Enable pacman parallel downloads
sudo sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

# Weekly pacman cache clearing
sudo pacman -Sy --noconfirm pacman-contrib
sudo systemctl enable paccache.timer

# Get some frequently used packages
sudo pacman -S --noconfirm neofetch htop git nano man-db exa wget

# Get yay AUR package helper
sudo pacman -S --needed --noconfirm git base-devel
sudo pacman -S --noconfirm go
git clone https://aur.archlinux.org/yay.git
(cd yay || exit 1; makepkg -si --noconfirm)
rm -rf yay

# Download downgrade
yay -S downgrade --noconfirm

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S --noconfirm i3 xorg i3status picom

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

# Set up display manager
# Use older versions where x_cmd is working (you can change --ala-only)
yes | sudo downgrade 'ly=0.5.3-5' --ala-only
sudo systemctl enable ly.service

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

# Download feh & set up wallpaper
sudo pacman -S --noconfirm feh
feh --bg-fill ./dotfiles/wallpaper.png

# Download dunst
sudo pacman -S --noconfirm dunst libnotify

# Download zsh
sudo pacman -S --noconfirm zsh
    # Make ~/.cache/zsh directory
    mkdir ~/.cache/zsh
    # Download zsh-syntax-highlighting
    sudo pacman -S --noconfirm zsh-syntax-highlighting
    # Download powerlevel10k
    yay -S --noconfirm zsh-theme-powerlevel10k-git
    # Download zsh-shift-select
    sudo git clone https://github.com/jirutka/zsh-shift-select /usr/share/zsh/plugins/zsh-shift-select

# Make ~/.local/bin directory
mkdir ~/.local/bin
# Make ~/.local/share/fonts directory
mkdir ~/.local/share/fonts
# Make ~/.cache/bash directory
mkdir ~/.cache/bash

##########################################
################## APPS ##################
##########################################

# Get alacritty terminal emulator (I want a lightweight terminal with opaque background)
sudo pacman -S --noconfirm alacritty
    # Download lightweight clipboard
    sudo pacman -S --noconfirm xclip
    # Install hack nerd fonts
    sudo pacman -S --noconfirm ttf-hack-nerd
    # Install xdg-utils (xdg-open)
    sudo pacman -S --noconfirm xdg-utils

# Download conky
sudo pacman -S --noconfirm conky

# Download i3lock-color & xautolock
sudo pacman -S --noconfirm --needed autoconf cairo fontconfig gcc libev libjpeg-turbo libxinerama libxkbcommon-x11 libxrandr pam pkgconf xcb-util-image xcb-util-xrm
sudo pacman -R --noconfirm i3lock
yay -S --noconfirm i3lock-color
sudo pacman -S --noconfirm xautolock

# Download brave browser (might change)
yay -S --noconfirm brave-bin

# Download neovim
sudo pacman -S --noconfirm neovim

# Download mc
sudo pacman -S --noconfirm mc

# System update
sudo pacman -Syu --noconfirm

# Run dotfiles.sh script
sleep 1
cd dotfiles || exit 1
./scripts/dotfiles.sh

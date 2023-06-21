#!/bin/bash

# Post install script for Arch Linux

# Setup colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"

if [ "$USER" != "root" ] 
then
    printf "[${RED}Fail${ENDCOLOR}] Use the setup script with 'sudo'!"
    exit
fi

# Functions

function change_sh() {
    sudo pacman -S dash
    printf "[${GREEN} Ok ${ENDCOLOR}] Downloaded Dash shell..."
    sudo rm /bin/sh
    sudo ln -s /bin/dash /bin/sh
    printf "[${GREEN} Ok ${ENDCOLOR}] Default shell running enviroment changed to dash"
}


# Enable pacman parallel downloads
sudo sed -i -n "s/#ParallelDownloads/ParallelDownload/" /etc/pacman.conf

# Weekly pacman cache clearing
sudo pacman -Sy pacman-contrib
sudo systemctl enable paccache.timer

# Get neofetch
sudo pacman -S neofetch

# Get htop
sudo pacman -S htop

# Get git
sudo pacman -S git

# Get nano editor
sudo pacman -S nano

# Get manuals
sudo pacman -S man-db

# Get exa ("better" ls)
sudo pacman -S exa

# Get yay AUR package helper
pacman -S --needed git base-devel
pacman -S --noconfirm go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Get alacritty terminal emulator (I want a lightweight terminal with opaque background)
sudo pacman -S alacritty

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S i3 xorg xorg-xdm dmenu i3status ttf-hack
echo “exec i3” > ~/.xsession
chmod +x ~/.xsession

# Enable X display manager
sudo systemctl enable xdm.service

# Fix boot messages disappearing
sudo sed -i -n s/TTYVTDisallocate=yes/TTYVTDisallocate=no/ /etc/systemd/system/getty.target.wants/getty@tty1.service 
sudo sed -i -n 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub

# Hide the GRUB boot menu
sudo sed -i -n "s/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub

# Run mkconfig for GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Check for bashisms
sudo pacman -S checkbashisms
return_value=$(checkbashisms -e)
if [ $return_value -e 0 ]; then
    if [ "$(find /bin/ -maxdepth 1 -type l -ls /bin/ | grep "/bin/sh -> bash" )" -e 0 ]; then
        printf "[${YELLOW}Warn${ENDCOLOR}] Default shell is not bash"
        printf "    Continue? [Y/N]"
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then 
            change_sh
        else
            printf "[${YELLOW}Warn${ENDCOLOR}] The default sh won't be changed"
        fi
    fi
    change_sh
fi


# Download brave browser (might change)
yay -S brave-bin

# System update
sudo pacman -Syu
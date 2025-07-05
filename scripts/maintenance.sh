#!/bin/sh

# Maintenance script for arch

# shellcheck disable=SC2312

printf "\033[1m[\033[33mWARN\033[0m\033[1m] This script will clear the terminal multiple times!\033[0m\n"
printf "       Press Enter to continue"
read -r _

# Refresh pacman mirrors
sudo cachyos-rate-mirrors --noconfirm

# Refresh pacman keyring (https://wiki.archlinux.org/title/Pacman/Package_signing#Tips_and_tricks)
sudo pacman -Sy --needed --noconfirm archlinux-keyring cachyos-keyring && sudo pacman -Su --noconfirm --needed

# Update system
sudo pacman -Syu --noconfirm

# Update AUR packages as well
paru -Syu --noconfirm
clear

printf "Showing systemctl errors\n"
sudo systemctl --failed
printf "Press Enter to continue"
read -r _
clear

# Show journal errors
printf "Showing journal errors\n"
sudo journalctl -p 3 -xb
printf "Press Enter to continue"
clear

# Show the size of the .cache & journal directory and others
printf "Showing important directory sizes\n"
du -sh ~/.cache/
du -sh /var/log/journal/
du -sh ~/.config
printf "Press Enter to delete the logs & clear the cache"
read -r _
clear

# Delete the journal logs up until 2 weeks
sudo journalctl --vacuum-time=2weeks

# Clean the cache (paccache.timer actually does this already)
sudo pacman -Sc --noconfirm
paru -Sc --noconfirm

# Delete orphan packages
sudo pacman -Qtdq --noconfirm | sudo pacman -Rns --noconfirm -
printf "Maintenance done!\n"


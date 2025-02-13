#!/bin/sh

# Maintenance script for arch

# shellcheck disable=SC2312

printf "\033[1m[\033[33mWARN\033[0m\033[1m] This script will clear the terminal multiple times!\033[0m\n"
printf "       Press Enter to continue"
read -r tmp

# Update system
sudo pacman -Syu --noconfirm

# Update AUR packages as well
yay -Syu --noconfirm
clear

printf "Showing systemctl errors\n"
sudo systemctl --failed
printf "Press Enter to continue"
read -r tmp
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
read -r tmp
clear

# Delete the journal logs up until 2 weeks
sudo journalctl --vacuum-time=2weeks

# Clean the cache (paccache.timer actually does this already)
sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

# Delete orphan packages
sudo pacman -Qtdq --noconfirm | sudo pacman -Rns --noconfirm -
printf "Maintenance done!\n"


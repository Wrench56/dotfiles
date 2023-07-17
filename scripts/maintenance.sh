#!/bin/bash

# Maintenance script for arch

# shellcheck disable=SC2312

printf "\033[1m[\e[33mWARN\e[0m\033[1m] This script will clear the terminal multiple times!\e[0m\n"
read -r -p "       Press Enter to continue" </dev/tty

# Update system
sudo pacman -Syu --noconfirm

# Update AUR packages as well
yay -Syu --noconfirm
clear

printf "Showing systemctl errors\n"
sudo systemctl --failed
read -r -p "Press Enter to continue" </dev/tty
clear

# Show journal errors
printf "Showing journal errors\n"
sudo journalctl -p 3 -xb
read -r -p "Press Enter to continue" </dev/tty
clear

# Show the size of the .cache & journal directory and others
printf "Showing important directory sizes\n"
du -sh ~/.cache/
du -sh /var/log/journal/
du -sh ~/.config
read -r -p "Press Enter to delete the logs & clear the cache" </dev/tty
clear

# Delete the journal logs up until 2 weeks
sudo journalctl --vacuum-time=2weeks

# Clean the cache (paccache.timer actually does this already)
sudo pacman -Sc --noconfirm
yay -Sc --noconfirm

# Delete orphan packages
sudo pacman -Qtdq --noconfirm | sudo pacman -Rns --noconfirm -
printf "Maintenance done!\n"

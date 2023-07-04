#!/bin/bash

# Script to symlink every dotfile where it needs to be

DOTFILES=$(dirname -- "$(realpath -- "$(dirname $(realpath -s $0))")")

# Wrapper
RED="\e[31m"
GREEN="\e[32m"
BOLD="\033[1m"
ENDCOLOR="\e[0m"

wrapper() {
    output=$(${@:2} 2>&1)
    if [[ $? -eq 0 ]]
    then
        printf "${BOLD}[${GREEN} Ok ${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\n"
    else
        printf "${BOLD}[${RED}Fail${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\n       ${BOLD}${RED}Error${ENDCOLOR} $output\n"
    fi
}

# ly display manager
wrapper "Remove default ly config.ini" sudo rm /etc/ly/config.ini
wrapper "Link ly config.ini" sudo ln -s $DOTFILES/ly/config.ini /etc/ly/config.ini

# i3
wrapper "Create i3 config directory" mkdir ~/.config/i3/ ~/.config/i3/config 
# Not sure if rm is needed
wrapper "Remove i3 config file" rm ~/.config/i3/config
wrapper "Link config file to i3 config directory" ln -s $DOTFILES/i3/config ~/.config/i3/config

# picom
wrapper "Create picom config directory" mkdir ~/.config/picom
wrapper "Link picom config file to picom directory" ln -s $DOTFILES/picom/picom.conf ~/.config/picom/picom.conf

# .xinitrc
wrapper "Make .xinitrc an executable" chmod +x $DOTFILES/.xinitrc
wrapper "Link .xinitrc to HOME directory" ln -s $DOTFILES/.xinitrc ~/.xinitrc

# .bashrc
wrapper "Remove default .bashrc file" rm ~/.bashrc
wrapper "Link .bashrc to HOME directory" ln -s $DOTFILES/.bashrc ~/.bashrc

# alacritty
wrapper "Create alacritty config folder" mkdir ~/.config/alacritty
wrapper "Link alacritty.yml to alacritty directory" ln -s $DOTFILES/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# rofi
wrapper "Create rofi config folder" mkdir ~/.config/rofi
wrapper "Link rofi config file to rofi directory" ln -s $DOTFILES/rofi/config.rasi ~/.config/rofi/config.rasi
wrapper "Link rofi theme file to rofi directory" ln -s $DOTFILES/rofi/theme.rasi ~/.config/rofi/theme.rasi

# neovim
wrapper "Link nvim config folder" ln -s $DOTFILES/nvim ~/.config/nvim
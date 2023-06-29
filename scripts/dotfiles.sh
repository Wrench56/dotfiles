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

# .xinitrc
wrapper "Make .xinitrc an executable" chmod +x $DOTFILES/.xinitrc
wrapper "Link .xinitrc to HOME directory" ln -s $DOTFILES/.xinitrc ~/.xinitrc

# .bashrc
wrapper "Remove default .bashrc file" rm ~/.bashrc
wrapper "Link .bashrc to HOME directory" ln -s $DOTFILES/.bashrc ~/.bashrc

# alacritty
wrapper "Create alacritty config folder" mkdir ~/.config/alacritty
wrapper "Link alacritty.yml to alacritty directory" ln -s $DOTFILES/alacritty/alacritty.yaml ~/.config/alacritty/alacritty.yaml

# neovim
wrapper "Link nvim config folder" ln -s $DOTFILES/nvim ~/.config/nvim
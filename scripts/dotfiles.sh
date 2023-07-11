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

# .Xresources
wrapper "Remove .Xresources" rm ~/.Xresources
wrapper "Link .Xresources to HOME directory" ln -s $DOTFILES/.Xresources ~/.Xresources

# GTK
wrapper "Make gtk-3.0 directory" mkdir ~/.config/gtk-3.0
wrapper "Link settings.ini to GTK 3.0 directory" ln -s $DOTFILES/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
wrapper "Link .gtkrc-2.0 to HOME directory" ln -s $DOTFILES/.gtkrc-2.0 ~/.gtkrc-2.0

# i3lock-color
wrapper "Remove ~/.local/bin/lock" rm ~/.local/bin/lock
wrapper "Link i3lock-color executable to ~/.local/bin/lock" ln -s $DOTFILES/i3lock/lock ~/.local/bin/lock
wrapper "Make ~/.local/bin/lock an executable" chmod +x ~/.local/bin/lock
wrapper "Remove ~/.local/bin/lock-notify" rm ~/.local/bin/lock-notify
wrapper "Link i3lock-color executable to ~/.local/bin/lock-notify" ln -s $DOTFILES/i3lock/lock-notify ~/.local/bin/lock-notify
wrapper "Make ~/.local/bin/lock an executable" chmod +x ~/.local/bin/lock-notify

# .bashrc
wrapper "Remove default .bashrc file" rm ~/.bashrc
wrapper "Link .bashrc to HOME directory" ln -s $DOTFILES/.bashrc ~/.bashrc

# .zshrc
wrapper "Remove .zshrc file" rm ~/.zshrc
wrapper "Link .zshrc to HOME directory" ln -s $DOTFILES/.zshrc ~/.zshrc
wrapper "Link zsh config directory to ~/.config/zsh " ln -s $DOTFILES/zsh ~/.config/zsh

# aliases
wrapper "Remove existing shell aliases" rm ~/.local/aliases
wrapper "Link shell aliases to ~/.local" ln -s $DOTFILES/shell/aliases ~/.local/aliases

# dunst
wrapper "Remove dunst config folder" rm -rf ~/.config/dunst
wrapper "Create dunst config folder" mkdir ~/.config/dunst
wrapper "Link dunstrc" ln -s $DOTFILES/dunst/dunstrc ~/.config/dunst/dunstrc
wrapper "Remove dunst icons from /usr/share/icons/" sudo rm -rf /usr/share/icons/dunst-icons
wrapper "Link dunst icons to /usr/share/icons/" sudo ln -s $DOTFILES/dunst/dunst-icons /usr/share/icons/dunst-icons

# conky
wrapper "Remove .conkyrc" rm ~/.conkyrc
wrapper "Link .conkyrc to HOME directory" ln -s $DOTFILES/.conkyrc ~/.conkyrc
wrapper "Copy ConkySymbols.ttf in ~/.local/share/fonts directory" cp $DOTFILES/fonts/ConkySymbols.ttf ~/.local/share/fonts/ConkySymbols.ttf
wrapper "Updating fontconfig cache" fc-cache

# alacritty
wrapper "Create alacritty config folder" mkdir ~/.config/alacritty
wrapper "Link alacritty.yml to alacritty directory" ln -s $DOTFILES/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# rofi
wrapper "Create rofi config folder" mkdir ~/.config/rofi
wrapper "Link rofi config file to rofi directory" ln -s $DOTFILES/rofi/config.rasi ~/.config/rofi/config.rasi
wrapper "Link rofi theme file to rofi directory" ln -s $DOTFILES/rofi/theme.rasi ~/.config/rofi/theme.rasi

# neovim
wrapper "Remove nvim config folder" rm -rf ~/.config/nvim
wrapper "Link nvim config folder" ln -s $DOTFILES/nvim ~/.config/nvim
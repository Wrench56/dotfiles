#!/bin/bash

# Script to symlink every dotfile where it needs to be

# shellcheck disable=SC2312

DOTFILES=$(dirname -- "$(realpath -- "$(dirname "$(realpath -s "$0")")")")

# Parameters:
#   $1 - Label
#   $2 - Command

wrapper() {
    output=$("${@:2}" 2>&1)
    if [[ $? -eq 0 ]]
    then
        printf "\033[1m[\e[32m Ok \e[0m\033[1m] %s\e[0m\n" "$1"
    else
        printf "\033[1m[\e[31mFail\e[0m\033[1m] %s\e[0m\n       \033[1m\e[31mError\e[0m $output\n" "$1"
    fi
}

# Parameters:
#   $1 - Path
make_executables() {
    for file in $1
    do
        wrapper "    Run chmod on $file" chmod +x "$file"
    done
}

# i3
wrapper "Create i3 config directory" mkdir ~/.config/i3/
wrapper "Remove i3 config file" rm ~/.config/i3/config
wrapper "Link config file to i3 config directory" ln -s "$DOTFILES/i3/config" ~/.config/i3/config

# .xinitrc
wrapper "Make .xinitrc an executable" chmod +x "$DOTFILES/.xinitrc"
wrapper "Link .xinitrc to HOME directory" ln -s "$DOTFILES/.xinitrc" ~/.xinitrc

# .Xresources
wrapper "Remove .Xresources" rm ~/.Xresources
wrapper "Link .Xresources to HOME directory" ln -s "$DOTFILES/.Xresources" ~/.Xresources

# GTK
wrapper "Make gtk-3.0 directory" mkdir ~/.config/gtk-3.0
wrapper "Link settings.ini to GTK 3.0 directory" ln -s "$DOTFILES/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
wrapper "Link .gtkrc-2.0 to HOME directory" ln -s "$DOTFILES/.gtkrc-2.0" ~/.gtkrc-2.0

# i3blocks
wrapper "Make i3blocks config directory" mkdir ~/.config/i3blocks
wrapper "Remove i3blocks config" rm ~/.config/i3blocks/config
wrapper "Link i3blocks config" ln -s "$DOTFILES/i3blocks/config" ~/.config/i3blocks/config
wrapper "Remove i3blocks scripts directory" rm -rf ~/.local/bin/i3blocks
wrapper "Link i3blocks scripts directory" ln -s "$DOTFILES/i3blocks/scripts" ~/.local/bin/i3blocks
printf "       \033[1mMake i3blocks scripts executable:\e[0m\n" 
make_executables "$HOME/.local/bin/i3blocks/*"

# .bashrc
wrapper "Remove default .bashrc file" rm ~/.bashrc
wrapper "Link .bashrc to HOME directory" ln -s "$DOTFILES/.bashrc" ~/.bashrc

# dunst
wrapper "Remove dunst config folder" rm -rf ~/.config/dunst
wrapper "Create dunst config folder" mkdir ~/.config/dunst
wrapper "Link dunstrc" ln -s "$DOTFILES/dunst/dunstrc" ~/.config/dunst/dunstrc
wrapper "Run dunst.sh script" "$DOTFILES/scripts/dunst.sh"
wrapper "Remove dunst icons from /usr/share/icons/" sudo rm -rf /usr/share/icons/dunst-icons
wrapper "Link dunst icons to /usr/share/icons/" sudo ln -s "$DOTFILES/dunst/dunst-icons" /usr/share/icons/dunst-icons

# nvim
wrapper "Clone nvim-config repository" git clone https://github.com/Wrench56/nvim-config ~/.config/nvim

# alacritty
wrapper "Create alacritty config folder" mkdir ~/.config/alacritty
wrapper "Link alacritty.toml to alacritty directory" ln -s "$DOTFILES/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

# rofi
wrapper "Create rofi config folder" mkdir ~/.config/rofi
wrapper "Link rofi config file to rofi directory" ln -s "$DOTFILES/rofi/config.rasi" ~/.config/rofi/config.rasi
wrapper "Link rofi theme file to rofi directory" ln -s "$DOTFILES/rofi/theme.rasi" ~/.config/rofi/theme.rasi
wrapper "Remove rofi menus" rm -rf ~/.local/bin/rofi
wrapper "Link rofi menus to ~/.local/bin/rofi" ln -s "$DOTFILES/rofi/menus" ~/.local/bin/rofi
printf "       \033[1mMake rofi menus executable:\e[0m\n"
make_executables "$HOME/.local/bin/rofi/rofi-*"

# maintenance.sh
wrapper "Link maintenance.sh to ~/.local/bin" ln -s "$DOTFILES/scripts/maintenance.sh" ~/.local/bin/maintenance.sh


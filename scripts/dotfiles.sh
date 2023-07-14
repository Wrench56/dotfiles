#!/bin/bash

# Script to symlink every dotfile where it needs to be

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

# ly display manager
wrapper "Remove default ly config.ini" sudo rm /etc/ly/config.ini
wrapper "Link ly config.ini" sudo ln -s "$DOTFILES/ly/config.ini /etc/ly/config.ini"

# i3
wrapper "Create i3 config directory" mkdir ~/.config/i3/
wrapper "Remove i3 config file" rm ~/.config/i3/config
wrapper "Link config file to i3 config directory" ln -s "$DOTFILES/i3/config ~/.config/i3/config"

# picom
wrapper "Create picom config directory" mkdir ~/.config/picom
wrapper "Link picom config file to picom directory" ln -s "$DOTFILES/picom/picom.conf" ~/.config/picom/picom.conf

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

# i3lock-color
wrapper "Remove ~/.local/bin/lock" rm ~/.local/bin/lock
wrapper "Link i3lock-color executable to ~/.local/bin/lock" ln -s "$DOTFILES/i3lock/lock" ~/.local/bin/lock
wrapper "Make ~/.local/bin/lock an executable" chmod +x ~/.local/bin/lock
wrapper "Remove ~/.local/bin/lock-notify" rm ~/.local/bin/lock-notify
wrapper "Link i3lock-color executable to ~/.local/bin/lock-notify" ln -s "$DOTFILES/i3lock/lock-notify" ~/.local/bin/lock-notify
wrapper "Make ~/.local/bin/lock an executable" chmod +x ~/.local/bin/lock-notify

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

# .zshrc
wrapper "Remove .zshrc file" rm ~/.zshrc
wrapper "Link .zshrc to HOME directory" ln -s "$DOTFILES/.zshrc" ~/.zshrc
wrapper "Link zsh config directory to ~/.config/zsh " ln -s "$DOTFILES/zsh" ~/.config/zsh

# aliases
wrapper "Remove existing shell aliases" rm ~/.local/aliases
wrapper "Link shell aliases to ~/.local" ln -s "$DOTFILES/shell/aliases" ~/.local/aliases

# keybinds
wrapper "Remove existing shell keybinds" rm ~/.local/keybinds
wrapper "Link shell keybinds to ~/.local" ln -s "$DOTFILES/shell/keybinds" ~/.local/keybinds

# dunst
wrapper "Remove dunst config folder" rm -rf ~/.config/dunst
wrapper "Create dunst config folder" mkdir ~/.config/dunst
wrapper "Link dunstrc" ln -s "$DOTFILES/dunst/dunstrc" ~/.config/dunst/dunstrc
wrapper "Run dunst.sh script" "$DOTFILES/scripts/dunst.sh"
wrapper "Remove dunst icons from /usr/share/icons/" sudo rm -rf /usr/share/icons/dunst-icons
wrapper "Link dunst icons to /usr/share/icons/" sudo ln -s "$DOTFILES/dunst/dunst-icons" /usr/share/icons/dunst-icons

# conky
wrapper "Remove .conkyrc" rm ~/.conkyrc
wrapper "Link .conkyrc to HOME directory" ln -s "$DOTFILES/.conkyrc" ~/.conkyrc
wrapper "Run conky.sh script" "$DOTFILES/scripts/conky.sh"
wrapper "Copy ConkySymbols.ttf in ~/.local/share/fonts directory" cp "$DOTFILES/fonts/ConkySymbols.ttf" ~/.local/share/fonts/ConkySymbols.ttf
wrapper "Updating fontconfig cache" fc-cache

# alacritty
wrapper "Create alacritty config folder" mkdir ~/.config/alacritty
wrapper "Link alacritty.yml to alacritty directory" ln -s "$DOTFILES/alacritty/alacritty.yml" ~/.config/alacritty/alacritty.yml

# rofi
wrapper "Create rofi config folder" mkdir ~/.config/rofi
wrapper "Link rofi config file to rofi directory" ln -s "$DOTFILES/rofi/config.rasi" ~/.config/rofi/config.rasi
wrapper "Link rofi theme file to rofi directory" ln -s "$DOTFILES/rofi/theme.rasi" ~/.config/rofi/theme.rasi
wrapper "Remove rofi menus" rm -rf ~/.local/bin/rofi
wrapper "Link rofi menus to ~/.local/bin/rofi" ln -s "$DOTFILES/rofi/menus" ~/.local/bin/rofi
printf "       \033[1mMake rofi menus executable:\e[0m\n"
make_executables "$HOME/.local/bin/rofi/rofi-*"

# neovim
wrapper "Remove nvim config folder" rm -rf ~/.config/nvim
wrapper "Link nvim config folder" ln -s "$DOTFILES/nvim" ~/.config/nvim

# mc (Midnight Commander)
wrapper "Remove mc config folder" rm -rf ~/.config/mc
wrapper "Create mc config folder" mkdir ~/.config/mc
wrapper "Link mc ini file" ln -s "$DOTFILES/mc/ini" ~/.config/mc/ini
wrapper "Remove ~/.local/share/mc/skins" rm -rf ~/.local/share/mc/skins
wrapper "Link mc skins folder" ln -s "$DOTFILES/mc/skins" ~/.local/share/mc/skins

#!/bin/bash

# Configure dunst scripts

USERNAME=$(whoami)
DOTFILES=$(dirname -- "$(realpath -- "$(dirname $(realpath -s $0))")")

# Replace @USER with the current username
cd $DOTFILES/dunst/script
for file in *; do sed -i "s/@USER/${USERNAME}/" $file; done
cd $DOTFILES/dunst/other
for file in *; do sed -i "s/@USER/${USERNAME}/" $file; done

# Link dunst/scripts directory to ~/.local/bin/dunst
if [ -d "~/.local/bin/dunst" ] then; rm -rf ~/.local/bin/dunst; fi
ln -s $DOTFILES/dunst/script ~/.local/bin/dunst

# Link rules
ln -s $DOTFILES/dunst/other/power.rules /etc/udev/rules.d/power.rules

# Link systemd files
for file in *
do
    if [ -d "~/.config/systemd/user/$file" ] then; rm ~/.config/systemd/user/$file; fi
    ln -s $file ~/.config/systemd/user/$file
done

# Enable user specific systemd services
systemctl --user enable battery.timer

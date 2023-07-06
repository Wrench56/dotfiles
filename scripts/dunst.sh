#!/bin/bash

# Configure dunst scripts

USERNAME=$(whoami)
DOTFILES=$(dirname -- "$(realpath -- "$(dirname $(realpath -s $0))")")

# Replace @USER with the current username
cd $DOTFILES/dunst/scripts
for file in *; do sed -i "s/@USER/${USERNAME}/" $file; done
cd $DOTFILES/dunst/other
for file in *; do sed -i "s/@USER/${USERNAME}/" $file; done

# Link dunst/scripts directory to ~/.local/bin/dunst
if [ -d ~/.local/bin/dunst ]; then rm -rf ~/.local/bin/dunst; fi
ln -s $DOTFILES/dunst/script ~/.local/bin/dunst

# Link rules
if [ -f /etc/udev/rules.d/power.rules ]; then sudo rm /etc/udev/rules.d/power.rules; fi
sudo ln -s $DOTFILES/dunst/other/power.rules /etc/udev/rules.d/power.rules

# Link systemd files
for file in *
do
    if [ -f ~/.config/systemd/user/$file ]; then rm ~/.config/systemd/user/$file; fi
    cp $file ~/.config/systemd/user/$file
done

# Enable user specific systemd services
systemctl --user enable battery.timer

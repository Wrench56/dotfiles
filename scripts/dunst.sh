#!/bin/bash

# Configure dunst scripts

USERNAME=$(whoami)
DOTFILES=$(dirname -- "$(realpath -- "$(dirname $(realpath -s $0))")")

# Install acpi
sudo pacman -S --noconfirm acpi

# Link dunst/scripts directory to ~/.local/bin/dunst
cd $DOTFILES/dunst/scripts
for file in *; do sed -i "s/@USER/${USERNAME}/g" $file; done

if [ -d ~/.local/bin/dunst ]; then rm -rf ~/.local/bin/dunst; fi
ln -s $DOTFILES/dunst/scripts ~/.local/bin/dunst

# Link rules
cd ../rules
for file in *; do sed -i "s/@USER/${USERNAME}/g" $file; done

for file in *
do
    if [ -f /etc/udev/rules.d/$file ]; then sudo rm /etc/udev/rules.d/$file; fi
    sudo ln -s $DOTFILES/dunst/rules/$file /etc/udev/rules.d/$file
done

# Link systemd files
cd ../services
for file in *; do sed -i "s/@USER/${USERNAME}/g" $file; done

for file in *
do
    if [ -f ~/.config/systemd/user/$file ]; then rm ~/.config/systemd/user/$file; fi
    ln -s $DOTFILES/dunst/services/$file ~/.config/systemd/user/$file
done

# Enable user specific systemd services
systemctl --user enable battery.timer

# Make scripts executable
cd ~/.local/bin/dunst
for file in *; do chmod +x $file; done

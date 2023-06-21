#!bin/bash

# Script to symlink every dotfile where it needs to be

$DOTFILES = ../

chmod +x $DOTFILES/.xinitrc
ln -s $DOTFILES/.xinitrc ~/.xinitrc
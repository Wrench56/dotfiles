# Dotfiles

<p align="center">My Arch dotfiles and configuration for zsh, i3, dunst, nvim, rofi and more!</p>

![Workspace](https://github.com/Wrench56/dotfiles/blob/main/resources/arch-workspace.png?raw=true)

<details><summary>More images</summary>
<p>
    <img src="https://github.com/Wrench56/dotfiles/blob/main/resources/arch-desktop.png?raw=true" alt="Desktop">
</p>
</details>

## Installation

The easiest way to install this configuration of Arch is to begin with a fresh installation of Arch Linux. Personally, I've used ``archinstall`` with pulseaudio, as this configuration needs pulseaudio.
### Network setup

To use curl, you must be connected to the internet. To do so, install NetworkManager, a well-known network manager default for many distros **during the first boot**. Use the command ``sudo pacman -S networkmanager``. After that, start its service with ``sudo systemctl enable NetworkManager.service``. To set up connections, use the ``nmcli`` tool or the ``nmtui`` terminal user interface. You can now safely reboot your machine (``sudo reboot``).

### Installing setup.sh

Run the setup.sh to install all of the configs and executables needed. You can download that from a fresh install Arch with the following command: ``curl -LJO https://raw.githubusercontent.com/Wrench56/dotfiles/main/scripts/setup.sh``. After that make `setup.sh` executable with `chmod +x setup.sh`. Then simply run it with `./setup.sh`.

## Goals

### Performance

This configuration of Arch Linux was designed to be very performant. I believe I achieved this. The system only uses ~780MB of memory, and the average CPU load is 1.5% right after boot. Although this configuration is not a real eye-candy, it has quite some useful features, like the extended dunst notification system, which sends additional notifications, e.g. when there are new package updates, your system temperature is too high or when you connect a new display. i3 scratchpads are of course a must too, and despite the fact that conky is pretty heavy, it is really a must, isn't it?

### Security

I want this system to be as secure as possible without losing much performance (e.g. I won't use hardened-linux). I believe the best way to defend your system is to be careful about what you download and use. That's why I tried not to use the AUR, despite the fact that it is a great help. Other than that, I did not really put much effort into making this system much safer, so upgrading the security is my future plan. 

## Tools & applications

 - Alacritty - Terminal emulator
 - Dunst -  Notification daemon
 - i3 - Tiling window manager
 - i3blocks - i3bar status generator
 - i3lock-color - Lockscreen
 - feh - Background manager
 - Firefox - Browser
 - ly - Login manager
 - mc - File manager (terminal based)
 - nvim - Editor (terminal based)
 - picom - Compositor
 - rofi - Application launcher & more
 - zsh - Shell

## Plans

I always wanted to try Debian (the debootstraped version). Later on, I might port over the setup script to be usable on Debian as well.

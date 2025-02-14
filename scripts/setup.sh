#!/bin/sh

# Post install script for Arch Linux

# shellcheck disable=SC2312

# Parameters:
#   $1 - Label
#   $2 - Command

wrapper() {
    cmd="$1"
    shift
    output=$("$@" 2>&1)
    status=$?
    if [ "$status" -eq 0 ]; then
        printf "\033[1m[\033[32m Ok \033[0m\033[1m] %s\033[0m\n" "$cmd"
    else
        printf "\033[1m[\033[31mFail\033[0m\033[1m] %s\033[0m\n       \033[1m\033[31mError\033[0m %s\n" "$cmd" "$output"
    fi
    return "$status"
}

# Enable pacman parallel downloads
wrapper "Enable parallel downloads for Pacman" sudo sed -i "s/#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf

# Weekly pacman cache clearing
wrapper "Enable Pacman cache clearing" sudo pacman -Sy --noconfirm --needed pacman-contrib; sudo systemctl enable paccache.timer 

# Get some frequently used packages
wrapper "Install common packages" sudo pacman -S --noconfirm --needed neofetch onefetch tokei htop git nano man-db exa wget bc unzip gdu speedtest-cli ripgrep github-cli

# Get i3 window manager (only install the gnu-free-fonts)
wrapper "Install Xorg and i3wm" sudo pacman -S --noconfirm --needed i3-wm xorg-server xorg-xinit i3blocks

wrapper "Install X specific packages" sudo pacman -S --noconfirm --needed xreader xorg-xrandr

# Get rofi
wrapper "Install Rofi" sudo pacman -S --noconfirm --needed rofi papirus-icon-theme

# Fix boot messages disappearing
wrapper "Fix logs disappearing on boot" sudo sed -i s/TTYVTDisallocate=yes/TTYVTDisallocate=no/ /etc/systemd/system/getty.target.wants/getty@tty1.service; sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"/' /etc/default/grub

# Run mkconfig for GRUB
wrapper "Run grub-mkconfig" sudo grub-mkconfig -o /boot/grub/grub.cfg

# Create user specific systemd service/timer directory
wrapper "Create systemd service/timer directory" mkdir -p ~/.config/systemd ~/.config/systemd/user

# Set dash as default /bin/sh
wrapper "Download dash" sudo pacman -S --noconfirm --needed dash
wrapper "Remove /bin/sh link" sudo rm /bin/sh
wrapper "Set dash as /bin/sh" sudo ln -s /bin/dash /bin/sh

# Configure bluetooth
wrapper "Install audio and bluetooth specific packages" sudo pacman -S --noconfirm bluez bluez-utils pipewire pipewire-pulse pipewire-alse wireplumber
# Enable btusb module if not already loaded
if [ "$(lsmod | grep -c "^btusb")" -eq 0 ]; then modprobe btusb; fi
wrapper "Enable pipewire" systemctl --user enable pipewire pipewire-pulse wireplumber
wrapper "Enable bluetooth service" sudo systemctl enable bluetooth

# Clone the dotfiles GitHub repository
wrapper "Clone dotfiles repository" git clone https://github.com/Wrench56/dotfiles

# Switch to correct branch
(
    cd dotfiles || exit
    wrapper "Checkout arch-minimal branch" git checkout arch-minimal
)

# Make the dotfiles scripts executable
wrapper "Remove setup.sh from the dotfiles repo" rm dotfiles/scripts/setup.sh
for file in ./dotfiles/scripts/*
do
    chmod +x "$file"
done

# Download dunst
wrapper "Install dunst" sudo pacman -S --noconfirm --needed dunst libnotify

# Make ~/.local/bin directory
wrapper "Create ~/.local/bin" mkdir -p ~/.local/bin
# Make ~/.local/share/fonts directory
wrapper "Create ~/.local/share/fonts" mkdir -p ~/.local/share/fonts
# Make ~/.cache/bash directory
wrapper "Create ~/.cache/bash" mkdir -p ~/.cache/bash
# Make ~/.config
wrapper "Create ~/.config" mkdir -p ~/.config
# Make ~/.secrets
wrapper "Create ~/.secrets" mkdir -p ~/.secrets


##########################################
################ LANGUAGES ###############
##########################################

# Install Python
wrapper "Install Python" sudo pacman -S --noconfirm --needed python python-pip

# Install Rust
wrapper "Install rustup" sudo pacman -S --noconfirm --needed rustup
wrapper "Install Rust toolchain" rustup default stable
wrapper "Install rust-analyzer" rustup component add rust-analyzer

# Install clang & gdb (debugger)
wrapper "Install clang and gdb" sudo pacman -S --noconfirm --needed clang gdb

# Install Node.js
wrapper "Install Node" sudo pacman -S --noconfirm --needed nodejs npm

##########################################
################### AUR ##################
##########################################

# Install paru
if sh -c "paru --version" >/dev/null 2>&1; then
    printf "\033[1m[    \033[1m] Skipping paru installation\033[0m\n"
else
    wrapper "Prepare paru installation" sudo pacman -S --noconfirm --needed base-devel
    wrapper "Clone paru repository" git clone https://aur.archlinux.org/paru.git
    (
        cd paru || exit 1
        wrapper "Install paru" makepkg -si --noconfirm
    )
    wrapper "Remove paru repository" rm -rf paru
fi

##########################################
################## APPS ##################
##########################################

# Get alacritty terminal emulator
wrapper "Install Alacritty" sudo pacman -S --noconfirm --needed alacritty
    # Download lightweight clipboard
    wrapper "Install xclip" sudo pacman -S --noconfirm --needed xclip
    # Install hack nerd fonts
    wrapper "Install ttf-hack-nerd" sudo pacman -S --noconfirm --needed ttf-hack-nerd
    # Install xdg-utils (xdg-open)
    wrapper "Install xdg-utils" sudo pacman -S --noconfirm --needed xdg-utils

# Download neovim
wrapper "Install Neovim" sudo pacman -S --noconfirm --needed neovim
    # Install lazygit
    wrapper "Install lazygit" sudo pacman -S --noconfirm --needed lazygit
    # Install jq & tidy (for rest.nvim)
    wrapper "Install jq and tidy" sudo pacman -S --noconfirm --needed jq tidy
    # Install pynvim
    wrapper "Install python-pynvim" sudo pacman -S --noconfirm --needed python-pynvim


# Download Qutebrowser
wrapper "Install Qutebrowser" sudo pacman -S --noconfirm --needed qutebrowser

# Download maim (snipping tool)
wrapper "Install screenshot tools" sudo pacman -S --noconfirm --needed maim xdotool

# System update
wrapper "Perform system update" sudo pacman -Syu --noconfirm --needed

# Run dotfiles.sh script
sleep 1
cd dotfiles || exit 1
./scripts/dotfiles.sh


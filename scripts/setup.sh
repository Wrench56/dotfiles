# Post install script for Arch Linux

# Get neofetch
sudo pacman -S neofetch

# Get htop
sudo pacman -S htop

# Get git
sudo pacman -S git

# Get nano editor
sudo pacman -S nano

# Get manuals
sudo pacman -S man-db

# Get exa ("better" ls)
sudo pacman -S exa

# Get yay AUR package helper
pacman -S --needed git base-devel
pacman -S --noconfirm go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Get alacritty terminal emulator (I want a lightweight terminal with opaque background)
sudo pacman -S alacritty

# Get i3 window manager (only install the gnu-free-fonts)
sudo pacman -S i3 xorg xorg-xdm dmenu i3status ttf-hack
echo “exec i3” > ~/.xsession
chmod +x ~/.xsession

# Enable X display manager
sudo systemctl enable xdm.service

# Download brave browser (might change)
yay -S brave-bin

# System update
sudo pacman -Syu
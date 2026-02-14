# Set font
setfont -d

# Connect to the internet
iwctl station wlan0 WiFi_BTW --passphrase **********

# Setting up partitions
cfdisk /dev/sda
+1G EFI Partition
+4G Swap Partition
Rest for linux file system

mkfs.ext4 /dev/sda3
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot/efi
swapon /dev/sda2

lsblk

# Installing core stuff
pacstrap /mnt linux linux-firmware sof-firmware base base-devel grub efibootmgr networkmanager neovim

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot and timezone stuff
arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Asia/Karachi /etc/localtime
date
hwclock --systohc
nvim /etc/locale.gen
**uncomment the en_US.UTF-8 first one**
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Hostname, user & Network stuff
echo "archlinux" >> /etc/hostname

useradd -m -G wheel -s /bin/bash hxt
passwd hxt
EDITOR=nvim visudo
**uncomment the first wheel entry**
su hxt
sudo pacman -Syu
exit
systemctl enable NetworkManager

# Bootloader and xorg
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S fastfetch btop
fastfetch -c examples/13
btop

pacman -Syu xorg-server xorg-xinit xorg-xrandr xclip xwallpaper xorg-xset xorg-xsetroot xorg-xdpyinfo

# Setting up the AUR helper
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Other stuff worth installing
pacman -S man tealdeer

### You're now pretty much good to go with whatever you want to install but (opinionated) window manager setup is below now.
pacman -Syu bspwm sxhkd alacritty rofi dmenu dunst git picom stow ttf-jetbrains-mono-nerd firefox

# Opinionated tools and stuff


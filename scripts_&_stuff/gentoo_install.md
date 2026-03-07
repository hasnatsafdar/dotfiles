# For SSH
- passwd root
- /etc/init.d/sshd start

 # Disk Partitioning (making boot, swap and root partition)
- fdisk /dev/vda
  o
  n
  p
  enter
  enter
  +256M
  n
  p
  enter
  enter
  +1G
  n
  p
  enter
  enter
  enter
  a
  1
  t
  2
  82
  w

mkfs.ext2 /dev/vda1 
mkswap /dev/vda2
swapon /dev/vda2
mkfs.ext4 /dev/vda3

# Mounting and working with Partitioned drive
mount /dev/vda3 /mnt/gentoo
cd /mnt/gentoo

# Installing the stage3 tarball
links https://gentoo.org/downloads
tar xpvf stage3-amd64-openrc-20251130T164554Z.tar.xz --xattrs-include='*.*' --numeric-owner
vi /mnt/gentoo/etc/portage/make.conf 
###### Inside make.conf add
MAKEOPTS="-j6"

# Mirrorselect
mirrorselect -i -o >> /etc/portage/make.conf
Freedif (HTTPS)
CICKU (HTTPS)
PlanetUnix (HTTPS)

cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"

cat etc/gentoo-release

mount /dev/vda1 /boot/

emerge-webrsync 

emerge --ask --verbose --update --deep --changed-use @world

echo "Asia/Karachi" > /etc/timezone

emerge --config sys-libs/timezone-data

emerge app-editors/vim

vim /etc/locale.gen
###### Uncomment the en_US.UTF-8 UTF-8
locale-gen

eselect locale set 4 

. /etc/profile

emerge --ask sys-kernel/gentoo-sources

eselect kernel set 1

ls -l /usr/src/linux

emerge --ask sys-apps/pciutils

cd /usr/src/linux

make menuconfig (optional)


emerge --ask sys-kernel/genkernel
eselect python list
echo 'PYTHON_SINGLE_TARGET="python3_11"' >> /etc/portage/make.conf
emerge --ask dev-lang/python:3.11
emerge --ask sys-kernel/genkernel
echo "sys-kernel/linux-firmware @BINARY-REDISTRIBUTABLE" | tee -a /etc/portage/package.license
emerge --ask sys-kernel/genkernel
etc-update
emerge --ask sys-kernel/genkernel

emerge --ask sys-kernel/linux-firmware

vim /etc/fstab
###### Uncomment and edit this stuff
/dev/sda1   /boot        xfs    defaults    0 2
/dev/sda2   none         swap    sw                   0 0
/dev/sda3   /            xfs    defaults,noatime              0 1

/dev/cdrom  /mnt/cdrom   auto    noauto,user          0 0

vim /etc/conf.d/hostname
###### set hostname

emerge --ask --noreplace net-misc/netifrc

vim /etc/config/net
add config_enp1s0="dhcp"

cd /etc/init.d/
ln -s net.lo net.enp1s0
rc-update add net.enp1s0 default
vim /etc/hosts

add the hostname then tab the local host

passwd

emerge --ask app-admin/sysklogd
rc-update add sysklogd default
emerge --ask sys-fs/e2fsprogs
emerge --ask net-misc/dhcpcd
emerge --ask --verbose sys-boot/grub
grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg

exit

umount -l /mnt/gentoo/dev/shm
umount -l /mnt/gentoo/dev/pts
umount -l /mnt/gentoo/dev
umount -l /mnt/gentoo/run
umount -l /mnt/gentoo/sys
umount -l /mnt/gentoo/proc
umount -l /mnt/gentoo

reboot
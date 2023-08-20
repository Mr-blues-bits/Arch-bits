#!/bin/bash

source logos.sh
source ff.sh
#source logos.sh

clear

bitsLogo

echo #
echo #
echo "Welcome to Arch Install Script:"

echo #
lsblk -f
echo #
# Call the function to show the Disk selection menu
show_disk_menu

echo #
final_disk_layout
ch_File_SystemMenu
set_filesystem


#lsblk "/dev/$disk" -f
#echo "DeBUG Point....This is final layout for this install: "
#read -p "exit now: " exitnow


#areyousureLogo

basesystemLogo
lsblk "/dev/$disk" -f

echo "Base packages selected for this install:"
echo #
echo "networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers avahi xdg-user-dirs xdg-utils nfs-utils bash-completion reflector iwd sof-firmware git nano"

echo #

while true; do

	read -p "Do you want to install Base System? Choose no to make changes to your previous install:(y/n) " yn
	case $yn in 
		[yY] ) echo Installing Base System;
		#pacstrap /mnt networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers avahi xdg-user-dirs xdg-utils nfs-utils bash-completion reflector iwd sof-firmware git nano
		echo #
		echo #
		echo "Generate File System Table (fstab)"
		genfstab -U /mnt >> /mnt/etc/fstab

		echo #
		echo "====>>Base system installation complete"
		echo "====>>"
		echo #
		echo #
		echo "We will switch to arch-choot now"
		# Copy the ch2.sh into the arch-chroot environment
		cp ch2.sh /mnt/ch2.sh
		cp logos.sh /mnt/logos.sh
		#cp DSS.sh /mnt/DSS.sh
		cp ff.sh /mnt/ff.sh
		cp start.sh /mnt/start.sh
		cp base.sh /mnt/base.sh
		# Enter the arch-chroot environment and execute the chroot script
		arch-chroot /mnt /bin/bash /ch2.sh
		break;;
		[nN] ) echo ok...we will proceed without installing base system;
			break;;
		* ) echo invalid response;;
	esac

	done
#Phase 2 lets install desktop environment 

deLogo

echo #
echo #
DE_menu
DE_select

Detect_VideoCard

theEndLogo
echo #
echo "Installation Complete.....Do you want to reboot."
#function ReSetAll () {
#
#Your reset function here.
#
#}



#!/bin/bash
source logos.sh

echo "Welcome to Arch Install Script:"

bitsLogo
echo #
# Call the function to show the selection menu
show_disk_menu
echo #
#lsblk -no NAME,FSTYPE,SIZE,MOUNTPOINT $diskSel

if [ "$(lsblk -no FSTYPE $diskSel)" != "" ]; then
 select_partition "Root"
  #read -p "Select root partition: " root_part
 select_partition "SWAP"
  #read -p "Select swap partition: " swap_part
 select_partition "Boot"
  #read -p "Select boot partition: " boot_part
fi

clear
echo #
	echo "Final Disk Layout"
	disksLogo

	echo #
	echo "Installing on $diskSel:"
	echo "Selected Root =========>>:$root_part"
	echo "Selected SWAP =========>>:$swap_part"
	echo "Selected Boot =========>>:$boot_part"
echo #
echo #

read -p "Please type 'yes' if you are happy with disk layout: " answer
    if [ "$answer" != "yes" ]; then
        echo "Exiting script."
        exit 1
    fi
echo #
echo #
	mount $root_part /mnt
	echo "Mounted $root_part at /mnt"
	mkdir -p "/mnt/boot/efi"

echo #
mount $boot_part /mnt/boot/efi
echo "Mounted $boot_part to /mnt/boot/efi"

echo #
swapon $swap_part
echo "Swap set on $swap_part"

echo "Disk section completed"

areyousureLogo

read -p "Now making changes to the system. Type yes to continue:" answer
    if [ "$answer" != "yes" ]; then
      	swapoff swap_part
 	umount -a
       echo "Exiting script."
       exit 1
    fi

basesystemLogo
echo "Base packages selected for this install:"
echo #
echo "networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers sof-firmware git nano"

echo #

while true; do

	read -p "Do you want to install Base System? Choose no to make changes to your previous install:(y/n) " yn
	case $yn in 
		[yY] ) echo Installing Base System;
		pacstrap /mnt networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers sof-firmware git nano konsole
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
		# Enter the arch-chroot environment and execute the chroot script
		arch-chroot /mnt /bin/bash /ch2.sh
		break;;
		[nN] ) echo ok...we will proceed without installing base system;
		arch-chroot	
   		break;;
		* ) echo invalid response;;
	esac

	done

theEndLogo
echo #
echo "Installation Complete. Final steps. Install nvidia drivers and a desktop environmnet of your choice."


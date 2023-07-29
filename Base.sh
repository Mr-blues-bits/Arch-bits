#!/bin/bash
source logos.sh

function show_disk_menu() {
    local disk_list=$(lsblk -ndo NAME,SIZE -e 7,11 --output NAME,SIZE)
    local options=()

    echo "Available disks:"
    while read -r name size; do
        options+=("$name ($size)")
    done <<< "$disk_list"
    PS3="Select a disk number: "
    select option in "${options[@]}"; do
        if [ -n "$option" ]; then
            disk=$(echo "$option" | awk '{print $1}')
            break
        else
            echo "Invalid choice. Please select a valid disk."
        fi
    done
}

# Function to display the menu and get user selection
select_partition() {
    partitions=()
    while IFS= read -r partition; do
        partitions+=("$partition")
    done < <(lsblk -nl -o NAME,MOUNTPOINT /dev/$disk*)

    # Display the menu options
    echo "Available partitions on /dev/$disk:"
    PS3="Select $1 partition number (1-$(( ${#partitions[@]} ))): "

    select option in "${partitions[@]}"; do
        # Check if a valid option is selected
        if [[ -n "$option" ]]; then

            if [ $1 == "Root" ]; then
	        root_part="/dev/$option"
            elif [ $1 == "SWAP" ]; then
            	swap_part="/dev/$option"
            elif [ $1 == "Boot" ]; then
            	boot_part="/dev/$option"
            fi

            diskSel="/dev/$option"
            break
        else
            echo "Invalid option. Please select a valid partition number."
        fi
    done
}

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
echo "Installing Base System..."
pacstrap /mnt networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers avahi xdg-user-dirs xdg-utils nfs-utils bash-completion reflector iwd sof-firmware git nano

genfstab -U /mnt >> /mnt/etc/fstab


localizationLogo

ln -sf /mnt/usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
echo "en_GB.UTF-8 UTF-8" > /mnt/etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf
echo #
echo #

# Prompt user for hostname
read -p "Enter the hostname for your system:" hostname
echo "Adding $hostname to the hostname file"
echo "$hostname" > /mnt/etc/hostname
echo #

echo "setup hosts file with loopback"
echo #
echo "========Setup hosts file============"
echo "127.0.0.1		localhost" >> /mnt/etc/hosts
echo "::1		Aocalhost" >> /mnt/etc/hosts
echo "127.0.1.1 	$hostname.localdomain $hostname" >> /mnt/etc/hosts
echo #
echo #
archChrootLogo
echo "Change to /mnt and finalize the install:"
echo #
echo #

cp ch2.sh /mnt/ch2.sh
arch-chroot /mnt /bin/bash /ch2.sh

theEndLogo
echo #
echo "Installation Complete. Final steps. Install nvidia drivers and a desktop environmnet of your choice."

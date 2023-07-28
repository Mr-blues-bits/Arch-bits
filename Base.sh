#!/bin/bash

echo "Welcome to Arch Install Script:"

function bitsLogo () {
echo -ne "


MMMMMMMM               MMMMMMMM                         BBBBBBBBBBBBBBBBB     iiii         ttttt
M:::::::M             M:::::::M                         B::::::::::::::::B   i::::i      ttt:::t
M::::::::M           M::::::::M                         B::::::BBBBBB:::::B   iiii       t:::::t
M:::::::::M         M:::::::::M                         BB:::::B     B:::::B             t:::::t
M::::::::::M       M::::::::::Mrrrrr   rrrrrrrrr          B::::B     B:::::Biiiiiiittttttt:::::ttttttt        ssssssssss
M:::::::::::M     M:::::::::::Mr::::rrr:::::::::r         B::::B     B:::::Bi:::::it:::::::::::::::::t      ss::::::::::s
M:::::::M::::M   M::::M:::::::Mr:::::::::::::::::r        B::::BBBBBB:::::B  i::::it:::::::::::::::::t    ss:::::::::::::s
M::::::M M::::M M::::M M::::::Mrr::::::rrrrr::::::r       B:::::::::::::BB   i::::itttttt:::::::tttttt    s::::::ssss:::::s
M::::::M  M::::M::::M  M::::::M r:::::r     r:::::r       B::::BBBBBB:::::B  i::::i      t:::::t           s:::::s   ssssss
M::::::M   M:::::::M   M::::::M r:::::r     rrrrrrr       B::::B     B:::::B i::::i      t:::::t              s::::::s
M::::::M    M:::::M    M::::::M r:::::r                   B::::B     B:::::B i::::i      t:::::t                 s::::::s
M::::::M     MMMMM     M::::::M r:::::r                   B::::B     B:::::B i::::i      t:::::t    ttttttssss     s:::::s
M::::::M               M::::::M r:::::r                 BB:::::BBBBBB::::::Bi::::::i     t::::::tttt:::::ts:::::ssss::::::s
M::::::M               M::::::M r:::::r                 B:::::::::::::::::B i::::::i     tt::::::::::::::ts::::::::::::::s
M::::::M               M::::::M r:::::r                 B::::::::::::::::B  i::::::i       tt:::::::::::tt s:::::::::::ss
MMMMMMMM               MMMMMMMM rrrrrrr                 BBBBBBBBBBBBBBBBB   iiiiiiii         ttttttttttt    sssssssssss



"

}

function disksLogo () {
echo -ne "

░█▀▀░▀█▀░█▀█░█▀█░█░░░░░█▀▄░▀█▀░█▀▀░█░█░░░█░░░█▀█░█░█░█▀█░█░█░▀█▀
░█▀▀░░█░░█░█░█▀█░█░░░░░█░█░░█░░▀▀█░█▀▄░░░█░░░█▀█░░█░░█░█░█░█░░█░
░▀░░░▀▀▀░▀░▀░▀░▀░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░


"
}

function basesystemLogo () {
echo -ne "

░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▄░█▀█░█▀▀░█▀▀░░░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█
░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█▀▄░█▀█░▀▀█░█▀▀░░░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█
░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀

"

}

function localizationLogo () {
echo -ne "

░█░░░█▀█░█▀▀░█▀█░█░░░▀█▀░▀▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█
░█░░░█░█░█░░░█▀█░█░░░░█░░▄▀░░█▀█░░█░░░█░░█░█░█░█
░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀

"
}

function areyousureLogo() {
echo -ne "

░█▀█░█▀▄░█▀▀░░░█░█░█▀█░█░█░░░█▀▀░█░█░█▀▄░█▀▀░░░▀▀█
░█▀█░█▀▄░█▀▀░░░░█░░█░█░█░█░░░▀▀█░█░█░█▀▄░█▀▀░░░░▀░
░▀░▀░▀░▀░▀▀▀░░░░▀░░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░▀░

"
}

function grubLogo() {
echo -ne "

░█▀▀░█▀▄░█░█░█▀▄
░█░█░█▀▄░█░█░█▀▄
░▀▀▀░▀░▀░▀▀▀░▀▀░

"
echo #

}

function userLogo() {
  echo -ne "
░█░█░█▀▀░█▀▀░█▀▄░█▀▀░░░█▀▀░█▀▀░▀█▀░█░█░█▀█
░█░█░▀▀█░█▀▀░█▀▄░▀▀█░░░▀▀█░█▀▀░░█░░█░█░█▀▀
░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░░

"
echo #
}

function servicemanagerLogo() {
  echo -ne "
  ░█▀▀░█▀▀░█▀▄░█░█░▀█▀░█▀▀░█▀▀░░░█▄█░█▀█░█▀█░█▀█░█▀▀░█▀▀░█▀▄
  ░▀▀█░█▀▀░█▀▄░▀▄▀░░█░░█░░░█▀▀░░░█░█░█▀█░█░█░█▀█░█░█░█▀▀░█▀▄
  ░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀▀▀░░░▀░▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀

  "
echo #
}

function theEndLogo() {
  echo -ne "

  ░█▀▀░█▀█░█▀█░█▀▀░█▀▄░█▀█░▀█▀░█░█░█░░░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
  ░█░░░█░█░█░█░█░█░█▀▄░█▀█░░█░░█░█░█░░░█▀█░░█░░░█░░█░█░█░█░▀▀█
  ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀

"
echo #
}


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
mount $boot_part /mnt
echo "Mounted $boot_part at /mnt"

dir = "/mnt/boot/efi"
if [! -d "$dir"]; then
	mkdir -p "$dir"
fi

echo #

mount $boot_part /mnt/boot/efi
echo "Mounted $root_part to /mnt/boot/efi"

echo #

swapon $swap_part
echo "Swap set on $swap_part"

echo "Disk section completed"

areyousureLogo

read -p "Now making changes to the system. Type yes to continue:" answer
    if [ "$answer" != "yes" ]; then
        echo "Exiting script."
        exit 1
    fi


basesystemLogo
echo "Installing Base System..."
pacstrap /mnt networkmanager base base-devel grub efibootmgr linux linux-firmware linux-headers avahi xdg-user-dirs xdg-utils nfs-utils bash-completion reflector iwd sof-firmware git nano

genfstab -L /mnt >> /mnt/etc/fstab


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

grubLogo

echo #
read -p "Please type 'yes' to install grub: " ganswer
    if [ "$ganswer" == "yes" ]; then
        echo "Installing Grub on /mnt/boot/efi."
        grub-install --target=x86_64-efi --efi-directory=/mnt/boot/efi --bootloader-id=GRUB
	       echo "Make grub confi file:"
	        grub-mkconfig -o /mnt/boot/grub/grub.cfg
    fi

    userLogo
    echo #
    echo "setup password for root user"
    passwd
    echo #

    echo "setup new user with sudo priviliges"

  # Check if the username is provided as an argument
  read -p "Enter new username:" usrName

	if [$usrName != "" ]; then
		read -p "Please provide username to continue" usrName
	fi


# Create the user with adduser command
echo "Adding $usrName to system"
useradd -m -G wheel $usrName

# Set a password for the new user

echo "Please enter a password for the user $usrName:"
passwd $usrName

# Grant wheel group sudo privileges
echo "grand wheel user sudo priviliges"

echo "%wheel ALL=(ALL:ALL) ALL" >> /mnt/etc/sudoers

echo "User $usrName has been created, the password is set, and they have been granted sudo privileges through the wheel group."

servicemanagerLogo

echo #
echo "Enabling Network Manager:..."
systemctl enable NetworkManager
echo "Enabling Avhil Service:..."
systemctl enable avahi-daemon


theEndLogo
echo #
echo "Installation Complete. Final steps. Install nvidia drivers and a desktop environmnet of your choice."

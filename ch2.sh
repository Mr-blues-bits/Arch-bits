#!/bin/bash
#chroot environment setup. this will finalize the installation for us.

source logos.sh

clear

archchrootLogo

localizationLogo
	echo "Setup time zone to /Europe/London"
	ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
	echo #""
	echo "Set hwclock --systohc"
		hwclock --systohc
	echo "set /etc/locale.gen to en_GB.UTF-8 UTF-8 and run locale-gen:"
	echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
		locale-gen
	echo "Adjust language for /etc/locale.conf"
	echo "LANG=en_GB.UTF-8" > /etc/locale.conf
	echo ""
	echo "Set KEYMAP=us:............"
	echo "KEYMAP=us" > /etc/vconsole.conf
	echo #
	echo #

# Prompt user for hostname
	read -p "Enter the hostname for your system:" hostname
	echo "Adding $hostname to the hostname file"
	echo "$hostname" > /etc/hostname
	echo #
	echo "setup hosts file with loopback"
	echo #
	echo "========Setup hosts file============"
	echo "127.0.0.1		localhost" >> /etc/hosts
	echo "::1		localhost" >> /etc/hosts
	echo "127.0.1.1 	$hostname.localdomain $hostname" >> /etc/hosts
	echo #
	echo #

grubLogo

echo #

	while true; do

	read -p "Do you want to install Grub? (y/n) " yn

	case $yn in 
		[yY] ) echo ok, we will proceed;
		 echo "Installing Grub on /boot/efi."
		 grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
		 echo "Make grub config file:"
		 grub-mkconfig -o /boot/grub/grub.cfg	
			break;;
		[nN] ) echo ok...we will proceed without installing grub;
			break;;
		* ) echo invalid response;;
	esac

	done


userLogo
    echo #
    echo "Setup password for root user"
    passwd
    echo #

    echo "Setup new user with sudo priviliges"

  # Check if the username is provided as an argument
  read -p "Enter new username:" usrName

	if [ $usrName == "" ]; then
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

echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "User $usrName has been created, the password is set, and they have been granted sudo privileges through the wheel group."

servicemanagerLogo
echo #
echo "Enabling Network Manager:..."
	systemctl enable NetworkManager
echo "Enabling Avhil Service:..."
	systemctl enable avahi-daemon

exit

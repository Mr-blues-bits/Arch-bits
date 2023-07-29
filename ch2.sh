#!/bin/bash
source logos.sh

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
	[nN] ) echo exiting...;
		break;;
	* ) echo invalid response;;
esac

done

echo #
echo "Enabling Network Manager:..."
systemctl enable NetworkManager
echo "Enabling Avhil Service:..."
systemctl enable avahi-daemon

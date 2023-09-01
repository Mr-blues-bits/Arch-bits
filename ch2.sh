#!/bin/bash

#chroot environment setup. this will finalize the installation for us.

source /Scripts/logos.sh



function install_Nvidia() {
   local cur_kernel=$(uname -r)
    echo "Checking kernel version: "
    nvidia_bol=true
    if echo "$cur_kernel" | grep -q -E -v -i "(lts|zen)"; then
        echo "No custom kernel detected....installing nvidia xorg-xrandr"
        nvidia_str="nvidia xorg-xrandr nvidia-utils"
        nvidia-xconfig
    else
        echo "We have a custom kernel install nvidia dkms"
        nvidia_str="nvidia-dkms xorg-xrandr nvidia-utils"
        nvidia-xconfig
    fi

    #echo "Nvidia Drivers installed and configured........"

}

function Detect_VideoCard () {
    echo -ne "\n\nDebug: Detecting Video Card......:\n"
    
    gpu_detect=$(lspci)
    #echo "Debug: Outup is: $gpu_detect" 

	case "${gpu_detect}" in
			 *nvidia*|*geforce*)
			 	echo -ne "\n\nInstalling Nvidia\n\n"
			 	install_Nvidia
				;;
			 *"vga compatible controller: Red hat"*)
			 	echo -ne "\n\nWe have found virtio GPU....installing qemu-hw-display-virtio-gpu\n\n"
        		gpu_str="qemu-hw-display-virtio-gpu"
				;;
			*Radeon*|*AMD*)
				echo -ne "\n\nVGA, Radeon AMD  detected......installing xf86-video-amdgpu:\n\n"
        		gpu_str="xf86-video-amdgpu"
				;;
			*"Integrated Graphics Controller"*)
				echo -ne "\n\nIGPU detectd.......installing libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa\n\n"
        		gpu_str="libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa"
				;;
			*"Intel Corporation UHD"*)
				echo -ne "\n\nIntel UHD detected.....installing libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa\n\n" 
        		gpu_str="libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa"
				;;
			*"VMware SVGA"*)
				echo -ne "\n\nWe have found VMware SVGA .....installing virtualbox-guest-utils\n\n"
        		gpu_str="virtualbox-guest-utils"
				;;
			*)
				echo -ne "\n\n We cound not detect any graphics card...Install manually please.\n\n"
				gpu_str=""
				;;
		esac
	#echo -ne "Debug: Video Card Detection Done......\n"

}

#################Desktop Environment Selection ##########################################
# Function to display the menu DE*
function DE_menu() {
	
	echo -ne "\n\n"
    echo "Choose a Linux desktop environment:"
    echo "1. GNOME"
    echo "2. KDE Plasma"
    echo "3. Xfce"
    echo "4. Cinnamon"
    echo "5. MATE"
    echo "6. None"
    echo "0. Exit"
}

# Function to read user input
function DE_read_choice() {
    read -p "Enter your choice (0-6): " choice
}

# Function to handle desktop environment selection
function DE_select() {
    while true; do
        DE_read_choice

        case $choice in
            0)
                echo "Exiting..."
				exit 0
                ;;
            1)
                echo "Now installing ans setting up GNOME."
                de_str="xorg-xinit xorg-server gnome gdm"
				de_service="gdm"
                break
                ;;
            2)
                echo "Now installing ans setting up KDE Plasma."
				de_str="xorg-xinit xorg-server plasma sddm"
				de_service="sddm"
                break
                ;;
            3)
                echo "Now installing ans setting up Xfce."
				de_str="xorg-xinit xfce4-goodies file-roller network-manager-applet leafpad epdfview galculator lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk"
				de_service="lightdm"
                break
                ;;
            4)
                echo "Now installing ans setting up Cinnamon."
                de_str="xorg-xinit cinnamon gnome-terminal lightdm lightdm-gtk-greeter"
				de_service="lightdm"
                break
                ;;
            5)
                echo "Now installing ans setting up MATE."
				de_str="xorg-server xorg-xinit mate-extra lightdm lightdm-gtk-greeter"
				de_service="lightdm"
                break
                ;;
	    6)
				echo "Continue without installing DE"
				de_str=""
				de_service=""
				break
				;;
            *)
                echo "Invalid choice. Please enter a number between 0 and 9."
                ;;
        esac

        display_menu
    done
}

#finalize desktop env
function Finalize_DE_Setup () {


		deLogo
		
		

	if [ "$InServiceMode" ]; then
        	#echo "we are in service mode. ::::::::::::::::::::::::::::::::::::::"

            while true; do
                    
                    read -p "Do you want to setup Desktop Environment?:(y/n) " yn
                    case $yn in 
                        [yY] ) echo DE Setup begins:;
						DE_menu
						DE_select
                        break;;
                        [nN] ) echo Service Mode Continues:;
                            
                            break;;
                        * ) echo invalid response;;
                    esac

            done
		elif [ ! "$InServiceMode" ]; then
			echo "we are not in service mode. will continue setup:"
			DE_menu
			DE_select
	fi

}


function Finalize_Localization () {

	localizationLogo
	if [ "$InServiceMode" ]; then
        	#echo "we are in service mode. ::::::::::::::::::::::::::::::::::::::"

            while true; do
                    
                    read -p "Do you want to setup localization settings:(y/n) " yn
                    case $yn in 
                        [yY] ) echo Localization setup begins:;
						LocalizationSetup
                        break;;
                        [nN] ) echo Service Mode Continues:;
                            
                            break;;
                        * ) echo invalid response;;
                    esac

            done
    	elif [ ! "$InServiceMode" ]; then
        	echo "we are not in service mode. will continue setup:"
		LocalizationSetup
	fi
}

#setup localization
function LocalizationSetup () {

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

}

function Install_Grub () {
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
}

function Finalize_userSetup () {

	userLogo
	if [ "$InServiceMode" ]; then
       # echo "we are in service mode. ::::::::::::::::::::::::::::::::::::::"

            while true; do
                    
                    read -p "Do you want to setup users:(y/n) " yn
                    case $yn in 
                        [yY] ) echo Localization setup begins:;
						userSetup
                        break;;
                        [nN] ) echo Service Mode Continues:;
                            
                            break;;
                        * ) echo invalid response;;
                    esac

            done
    elif [ ! "$InServiceMode" ]; then
        echo "we are not in service mode. will continue setup:"
		userSetup
	fi

}

function userSetup() {
	#use getent passwd
	#to list all users on the system.
	
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

}

function ServiceManagerSetup() {
	
	servicemanagerLogo
	
	while true; do
		echo #
		read -p "Do you want to enable installed services now(y/n)?" yn
		echo #
		case $yn in 
			[yY] ) echo . Enable Services ...........;
				echo #
				de_service+=",NetworkManager,avahi-daemon"

				sep_str=","
				substrings=($(split_string "$de_service" "$sep_str"))
				for substring in "${substrings[@]}"; do
					if systemctl enable "$substring"; then
						echo "Service $substring enabled successfully."
					else
						echo "Failed to enable service $substring."
					fi
				done
					break;;
			[nN] ) echo Exiting.......;
				break;;
			* ) echo invalid response;;
		esac

		done
}

function FinalPacmanStr() {

	echo "Debug: FinalPacmanStr Called...."

	if [[ "$nvidia_bol" = "true" ]]; then
		echo -ne "Debug: Nvidia Card found. \n"
		final_str="${nvidia_str} ${de_str}"

	else
		echo -ne "Debug: Nvidia not found.\n"
		final_str="${gpu_str} ${de_str}"
	fi

	while true; do
		echo #
		echo $final_str
		read -p "Do you want to install these packages (y/n)?" yn
		echo #
		case $yn in 
			[yY] ) echo Installing now......;
			pacman -S --noconfirm $final_str
				break;;
			[nN] ) echo Exiting.......;
				break;;
			* ) echo invalid response;;
		esac

		done

}

# Function to split a string into an array of substrings
function split_string() {
    local input_string="$1"
    local delimiter="$2"

    # Save the current value of IFS
    local OLD_IFS=$IFS

    # Set IFS to the specified delimiter
    IFS="$delimiter"

    # Store the separated substrings in an array
    local substrings=($input_string)

    # Restore the original IFS value
    IFS=$OLD_IFS

    # Return the array of substrings
    echo "${substrings[@]}"
}

clear
archchrootLogo

#Setup localization
Finalize_Localization
Finalize_userSetup
Finalize_DE_Setup

clear
#Video card detection
videocardLogo
Detect_VideoCard
#Finally install required packages
FinalPacmanStr
#Enable services
ServiceManagerSetup
#Finally install GRUB
Install_Grub	


#......................Setup Completed...................................

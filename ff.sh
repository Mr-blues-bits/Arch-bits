#!/bin/bash
#source logos.sh
echo "ff.sh source file loaded."

function show_disk_menu() {
   echo "Inside show disk menu:"
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

function final_disk_layout() {


    if [ "$(lsblk -no FSTYPE $diskSel)" != "" ]; then
    select_partition "Root"
    #read -p "Select root partition: " root_part
    select_partition "SWAP"
    #read -p "Select swap partition: " swap_part
    select_partition "Boot"
    #read -p "Select boot partition: " boot_part
    fi

    #clear
    echo #
        echo "Final Disk Layout"
        disksLogo

        echo #
        echo "Installing on $diskSel:"
        echo "Selected Root =========>>:$root_part"
        echo "Selected SWAP =========>>:$swap_part"
        echo "Selected Boot =========>>:$boot_part"
    echo #

}

# Function to display the menu and get user selection
function select_partition() {
    partitions=()
    while IFS= read -r partition; do
        partitions+=("$partition")
    done < <(lsblk -nl -o NAME,MOUNTPOINT /dev/$disk*)

    # Display the menu options
    echo "Available partitions on /dev/$disk:"
    PS3="Select $1 partition number (1-$(( ${#partitions[@]} ))): "
    if $partitions <= 1 ; then
        echo "disk does not have partitions"
    fi

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

#################Desktop Environment Selection ##########################################
# Function to display the menu DE*
function DE_menu() {
    echo "Choose a Linux desktop environment:"
    echo "1. GNOME"
    echo "2. KDE Plasma (Default)"
    echo "3. Xfce"
    echo "4. Cinnamon (Recommended)"
    echo "5. MATE"
    echo "6. LXQt"
    echo "7. Budgie"
    echo "8. Unity (if available)"
    echo "9. Other (specify your choice)"
    echo "0. Exit"
}

# Function to read user input
function DE_read_choice() {
    read -p "Enter your choice (0-9): " choice
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
                echo "You chose GNOME."
                pacman -S --noconfirm --needed gnome gdm
                systemctl enable gdm
                break
                ;;
            2)
                echo "You chose KDE Plasma."
                pacman -S --noconfirm --needed kde-plasma-desktop sddm
                systemctl enable sddm
                break
                ;;
            3)
                echo "You chose Xfce."
                break
                ;;
            4)
                echo "You chose Cinnamon."
                pacman -S --noconfirm --needed cinnamon lightdm
                systemctl enable lightdm
                break
                ;;
            5)
                echo "You chose MATE."
                break
                ;;
            6)
                echo "You chose LXQt."
                break
                ;;
            7)
                echo "You chose Budgie."
                break
                ;;
            8)
                echo "You chose Unity (if available)."
                break
                ;;
            9)
                read -p "Enter the name of the desktop environment: " custom_choice
                echo "You chose $custom_choice."
                break
                ;;
            *)
                echo "Invalid choice. Please enter a number between 0 and 9."
                ;;
        esac

        display_menu
    done
}

#Function to handle select file system
function ch_File_SystemMenu() {
    echo "Choose your filesystem for system root:"
    echo "1. ext3"
    echo "2. ext4"
    echo "3. btrfs"
    echo "0. Exit"
}

#Function to read filesystem choice
function read_fschoice() {
    read -p "Enter your choice (0-3): " choice
}

function cc() {
    clear
    areyousureLogo

    echo "WARNING::::: This will format $root_part with btrfs and setup subvolumes.:::::"
    while true; do
                read -p "WARNING::::: This will wipe all data on $root_part. Are you sure you want to continue?(y/n)" yn
                case $yn in 
	                [yY] ) echo ok, we will proceed;
		                break;;
	                [nN] ) echo exiting...;
		                exit;;
	                * ) echo invalid response;;
                esac

    done
}

#Funtion to handle file system selection
function set_filesystem() {
    while true; do
        
        read_fschoice

        case $choice in
            0)
                echo "Exiting..."
                exit 0
                ;;
            1)
                cc
                echo "You chose ext3."
                mkfs.ext3 -F $root_part
                mount_non_btrfs_partitions
                break
                ;;
            2)
                cc
                echo "You chose ext4."
                mkfs.ext4 -F $root_part
                mount_non_btrfs_partitions
                break
                ;;
            3)
                cc
                echo "Setting up btrfs......"
                mkfs.btrfs -F $root_part
                EnableSubvolumes
                break
                ;;
            *)
                echo "Invalid choice. Please enter a number between 0 and 3."
                ;;
        esac

        ch_File_SystemMenu
    done
}

function CheckFS() {
	#This function returns file system of given partition
	FS = blkid -s Type - value $1 

}

# Create sub volumes on root partition
function CreatesubVols () {
    btrfs subvolume create /mnt/@
    btrfs subvolume create /mnt/@home
    btrfs subvolume create /mnt/@var
    btrfs subvolume create /mnt/@tmp
    btrfs subvolume create /mnt/@.snapshots
}

# Mount All btrfs sub volumes,boot and swap.
function mountSubvol () {
	
    mount -o noatime,compress=lzo,space_cache=v2,subvol=@home $root_part /mnt/home
    mount -o noatime,compress=lzo,space_cache=v2,subvol=@tmp $root_part /mnt/tmp
    mount -o noatime,compress=lzo,space_cache=v2,subvol=@var $root_part /mnt/var
    mount -o noatime,compress=lzo,space_cache=v2,subvol=@.snapshots $root_part /mnt/.snapshots

    echo #
    mount $boot_part /mnt/boot/efi
    echo "Mounted $boot_part to /mnt/boot/efi"

    echo #
    mkswap $swap_part
    swapon $swap_part
    echo "Swap set on $swap_part"
}

function EnableSubvolumes () {
    #Mount Root partition before continuing.
    mount $root_part /mnt
    #lets create sub volumes
    CreatesubVols     
    # unmount root to remount subvolume
    umount /mnt
    # mount @ subvolume
        mount -o noatime,compress=lzo,space_cache=v2,subvol=@ $root_part /mnt
    # make directories home, .snapshots, var, tmp
        mkdir -p /mnt/{home,var,tmp,.snapshots}
    # mount subvolumes
        mountSubvol
}

function mount_non_btrfs_partitions() {
    echo "Mounting partitions"

	mount $root_part /mnt
	echo "Mounted $root_part at /mnt"
	mkdir -p "/mnt/boot/efi"

    echo #
    mount $boot_part /mnt/boot/efi
    echo "Mounted $boot_part to /mnt/boot/efi"

    echo #
    mkswap $swap_part
    swapon $swap_part
    echo "Swap set on $swap_part"
}

function install_Nvidia() {
    cur_kernel=$(uname -r)
    echo "Checking kernel version: "
    
    if echo "$cur_kernel" | grep -q -E -v -i "(lts|zen)"; then
        echo "No custom kernel detected....installing nvidia xorg-xrandr"
        pacman -S --noconfirm --needed nvidia xorg-xrandr nvidia-utils
        nvidia-xconfig
    else
        echo "We have a custom kernel install nvidia dkms"
        pacman -S --noconfirm --needed nvidia-dkms xorg-xrandr nvidia-utils
        nvidia-xconfig
    fi

    echo "Nvidia Drivers installed and configured........"

}

function Detect_VideoCard () {
    echo "inside VideoCard function:"
    
    gpu_detect=$(lspci)
    #echo "Outup is: $gpu_detect" 

    if grep -E -i "NVIDIA|GeForce" <<< ${gpu_detect}; then
        install_Nvidia
    elif grep -E -i "vga compatible controller: Red hat" <<< ${gpu_detect}; then 
        echo "We have found virtio GPU....installing qemu-hw-display-virtio-gpu xorg"
        pacman -S --noconfirm --needed xorg qemu-hw-display-virtio-gpu xorg
    elif grep -E -i 'VGA' | grep -E -i "Radeon|AMD" <<< ${gpu_detect}; then
        echo "VGA, Radeon AMD  detected......installing xf86-video-amdgpu:"
        pacman -S --noconfirm --needed xf86-video-amdgpu
    elif grep -E -i "Integrated Graphics Controller" <<< ${gpu_detect}; then
        echo "IGPU detectd.......installing libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa"
        pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
    elif grep -E -i "Intel Corporation UHD" <<< ${gpu_detect}; then
        echo "Intel UHD detected.....installing libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa" 
        pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
    elif grep -E -i "VMware SVGA" <<< ${gpu_detect}; then 
        echo "We have found VMware SVGA .....installing xorg virtualbox-guest-utils"
        pacman -S --needed --noconfirm xorg virtualbox-guest-utils
    fi

}

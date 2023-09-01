#!/bin/bash
#This file contains all function needed for phase 1 of the installation


function disk_has_partitions() {


    partition_count=$(grep -c "$1[0-9]" /proc/partitions)

    echo "value set at: $partition_count "

    if [[ $partition_count -gt 2 ]]; then
    echo "The disk has $partition_count partitions."
    else
        cfdisk /dev/$disk

        if [[ $partition_count -gt 2 ]]; then
            echo "The disk has $partition_count partitions."
        else
            clear

            echo #
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t The $1 has no partitions. Exiting.............\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Run cfdisk or cgdisk to easily make new partitions\n"     
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t We need a boot partition minimum size 300M to 1G\n"
            echo -ne "\t We need a root partition minimum 20G or bigger\n"
            echo -ne "\t We need a root partition minimum 20G or bigger\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Just make partitions no need to setup filesystems.\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Rerun script after you have done your partitions. thanks\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo #
            exit

        fi

        

    fi
   
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

function final_disk_layout() {
    #echo "Inside final disk layout::::::::::::::::::::::::::::::::::::::"
    echo "selected disk is: $disk:"
    if parted -s /dev/$disk print | grep -q "Number"; then

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
            disksLogo
            #echo "Final Disk Layout"
            local DiskSize=($(lsblk -no SIZE /dev/$disk))
            lsblk "/dev/$disk" -f 
            echo #
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Installing on disk:/dev/$disk:  Total Capacity: $DiskSize\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Selected Root \t>\t $root_part:\t(Size:$(lsblk -no SIZE $root_part))\n"     
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Selected SWAP \t>\t $swap_part:\t(Size:$(lsblk -no SIZE $swap_part))\n"
            echo -ne "\t---------------------------------------------------------------------\n"
            echo -ne "\t Selected Boot \t>\t $boot_part:\t(Size:$(lsblk -no SIZE $boot_part))\n"
            echo -ne "\t---------------------------------------------------------------------\n"
        echo #
    else   
            echo "Error: No partition found. Please run this script again."
            exit

    fi

} 

# Function to display the menu and get user selection
function select_partition() {

    echo "Available partitions on /dev/$disk:"

        partitions=($(lsblk -no NAME /dev/$disk))
        partition_list=()
    for partition in "${partitions[@]}"; do
        if [[ $partition != "$disk" ]]; then
            partition_list+=("$partition")
        fi
    done
    PS3="Select the $1 partition (1-${#partition_list[@]}): "
    select option in "${partition_list[@]}"; do
        if [[ -n "$option" && $REPLY -ge 1 && $REPLY -le ${#partition_list[@]} ]]; then
            selected_partition="$option"
            
            local input_string="$option"
            selected_partition=$(echo "$option" | sed 's/[^a-zA-Z0-9]//g')
            
            echo "You selected partition: $selected_partition"
            if [ $1 == "Root" ]; then
	            root_part="/dev/$selected_partition"
            elif [ $1 == "SWAP" ]; then
            	swap_part="/dev/$selected_partition"
            elif [ $1 == "Boot" ]; then
            	boot_part="/dev/$selected_partition"
            fi
            break
        else
            echo "Invalid option. Please select a valid partition number."
        fi
    done

    
} 

#Function to handle select file system
function ch_File_SystemMenu() {
    echo "Choose your filesystem for system Root:"
    echo "1. ext3 (format existing data)"
    echo "2. ext4 (format existing data)"
    echo "3. btrfs (format existing data)"
    echo "4. Mount non btrfs (no format)"
    echo "5. Mount btrfs (no format)"
    echo "6  Enable Service Mode (no format)"
    echo "0. Exit"
} 

#Function to read filesystem choice
function read_fschoice() {
    read -p "Enter your choice (0-5): " choice
}

# A function to display confirmation prompt
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

function set_swapfilesystem () {

        if [[ $(file -sL $swap_part) != *"swap"* ]]; then
            echo "$swap_part is not configured as swap."
            mkswap $swap_part 
            swapon $swap_part
            echo "Swap set on $swap_part"
        else
            swapon $swap_part
            echo "Swap set on $swap_part"
        fi
    
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
                umountAllSystems
                echo "You chose ext3."
                mkfs.ext3 -F $root_part
                mount_non_btrfs_partitions
                break
                ;;
            2)
                cc
                umountAllSystems
                echo "You chose ext4."
                mkfs.ext4 -F $root_part
                mount_non_btrfs_partitions
                break
                ;;
            3)
                cc
                umountAllSystems
                echo "Setting up btrfs......"
                mkfs.btrfs -F $root_part
                EnableSubvolumes
                break
                ;;
            4)
                echo "Mount non btrfs file system"
                umountAllSystems
                mount_non_btrfs_partitions 
                #also enable service mode
                    echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n"
                    echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n\n"
                InServiceMode=true
                break
                ;;
            5) 
                echo "Mount btrfs file system"
                umountAllSystems
                mountSubvol
                #also enable service mode
                    echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n"
                    echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n\n"
                InServiceMode=true
                break
                ;;
            6)
                echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n"
                echo -ne " ::::::::::::::::::::Service Mode Enabled:::::::::::::::::::::::::\n\n"
                InServiceMode=true
                break
                ;;
            *)
                echo "Invalid choice. Please enter a number between 0 and 5."
                ;;
        esac

        ch_File_SystemMenu
    done
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
function mountSubvol() {
	  local mntpoint="$1"
	  subvols=$(btrfs subvolume list /mnt | awk '/ID/ &&!index($NF, "/") {print $NF}')
	  echo "Debug: subvols set:...................."  
	    umount /mnt
	  # Mount each user subvol
	  while read -r line; do
	   # echo "Debug:............$line"
	  
	      if [[ $line =~ @.+[A-Za-z0-9].* ]]; then
	        subvol_mountpoint="${line/@/}"
	              if ! dirExists "/mnt/$subvol_mountpointth"; then
	              echo "$subvol_mountpoint directory does not exist"
	              mkdir -p /mnt/$subvol_mountpoint
	              fi
	
	        echo "Mounting-->1: mount noatime,compress=lzo,space_cache=v2,subvol=@$subvol_mountpoint /dev/sda3 /mnt/$subvol_mountpoint"
	                            mount -o noatime,compress=lzo,space_cache=v2,subvol=@$subvol_mountpoint /dev/sda3 /mnt/$subvol_mountpoint
	      else
	        echo "Mounting-->2: mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/sda3 /mnt"
	                            mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/sda3 /mnt
	      fi   
	  done <<< "$subvols"
}


#enable subvolumes
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

#mount file systems
function mount_non_btrfs_partitions() {
    echo "Mounting partitions"
     if ! is_mounted "/mnt"; then
    	mount $root_part /mnt
	fi
        echo -ne "Mounted $root_part at /mnt \n"
        echo #
}


function mount_boot_efi () {

    echo "We are checking: $boot_part"
    
    bootEfifs=$(FindTheFileSystem "$boot_part")
    echo "FS is: $bootEfifs"

    if [[ "$bootEfifs" != *"vfat"* ]]; then
        echo "Debug: Will format Boot partition."
        mkfs.vfat -F 32 $boot_part
    fi

   
    path="/mnt/boot/efi"
    if ! dirExists "$path"; then
        mkdir -p /mnt/boot/efi
    fi

    if ! is_mounted "/mnt/boot/efi"; then
        mount $boot_part /mnt/boot/efi
        echo "Mounted $boot_part at /mnt/boot/efi"
    else
        echo "$boot_part Already mounted at /mnt/boot/efi"
    fi
   
}

function umountAllSystems () {
            umount /mnt/*
            umount /mnt/.*
            #umount /mnt/boot/efi
            umount /mnt/boot/efi
            umount /mnt
			echo "System unmounted successfully: "
            lsblk -f /dev/sda3

}

function FindTheFileSystem() {
    local partition="$1"
    local filesystem
    filesystem=$(blkid -s TYPE -o value "$partition")
    echo "$filesystem"
        #Simple usage
        #partition="/dev/sda1"
        #filesystem=$(FindTheFileSystem "$partition")
        #echo "Filesystem of $partition is $filesystem"

}


#this function check if a given mount point exists
function is_mounted() {
    local mount_point="$1"
    
    if grep -qs "$mount_point" /proc/mounts; then
        return 0  # Return true (0) if mounted
    else
        return 1  # Return false (1) if not mounted
    fi
}

#this function check if given directory exists
function dirExists() {
    local path="$1"
    
    if [ -e "$path" ]; then
        return 0  # Return true (0) if exists
    else
        return 1  # Return false (1) if doesn't exist
    fi
}

function InstallBaseSystem () {

    lsblk "/dev/$disk" -f
    echo #

    echo -ne "Base packages selected for this install:\n\n"

    
    echo -ne "Chosen pkackage:$pkgQue \n\n"
    
    if [ ! "$InServiceMode" ]; then
            while true; do
                read -p "Do you want to install Base System?:(y/n) " yn
                case $yn in 
                    [yY] ) echo Installing Base System;
                
                        echo -ne "Debug: Inside pacstrap:\n"
                        pacstrap /mnt $pkgQue
                        echo #
                        echo #
                        echo -ne "Generate File System Table (fstab)\n"
                        echo "" > /mnt/etc/fstab
                        genfstab -U /mnt >> /mnt/etc/fstab
                        echo #
                        echo "====>>Base system installation complete"
                        echo "====>>"
                        echo #
                        echo #
                    
                    break;;
                    [nN] ) echo ok...we will proceed without installing base system;
                        exit
                        break;;
                    * ) echo invalid response;;
                esac

                done
    else 
                     
        echo -ne "We are in Service mode. Continue without pacstrap:\n"
    fi
}

function ArchChRoot () {
    echo #
    echo #
    echo #
   while true; do
        
        read -p ":::PHASE 2::: Do you want to switch to chroot?:(y/n) " yn
        case $yn in 
            [yY] ) echo We will switch to arch-choot now;
            #copy all files to root/Scripts directory to continue with Stage 2
            mkdir /mnt/Scripts
            cp ch2.sh /mnt/Scripts/ch2.sh
            cp logos.sh /mnt/Scripts/logos.sh
            cp start.sh /mnt/Scripts/start.sh
            cp base.sh /mnt/Scripts/base.sh
            cp single.sh /mnt/Scripts/single.sh
            cp vs.sh /mnt/Scripts/vs.sh

            # Enter the arch-chroot environment and execute the chroot script
            arch-chroot /mnt /bin/bash /Scripts/ch2.sh
            
            break;;
            [nN] ) echo Service Mode check before exiting.........;

            if [ "$InServiceMode" ]; then
                echo "We are in service mode. Continues with Chroot:"
                arch-chroot /mnt /bin/bash /Scripts/ch2.sh
            elif [ ! "$InServiceMode" ]; then
                echo "We are not in service mode. Exit Confirmed:"
                exit
            fi
                break;;
            * ) echo invalid response;;
        esac

    done
   
    
}


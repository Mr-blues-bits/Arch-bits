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

function archchrootLogo () {
echo -ne "

░█░█░█▀▀░█░░░█▀▀░█▀█░█▄█░█▀▀░░░▀█▀░█▀█░░░█▀█░█▀▄░█▀▀░█░█░░░░░█▀▀░█░█░█▀▄░█▀█░█▀█░▀█▀
░█▄█░█▀▀░█░░░█░░░█░█░█░█░█▀▀░░░░█░░█░█░░░█▀█░█▀▄░█░░░█▀█░▄▄▄░█░░░█▀█░█▀▄░█░█░█░█░░█░
░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░▀░░▀▀▀░░░▀░▀░▀░▀░▀▀▀░▀░▀░░░░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░

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


#################Desktop Environment Selection ##########################################

# Function to display the menu
function display_menu() {
    echo "Choose a Linux desktop environment:"
    echo "1. GNOME"
    echo "2. KDE Plasma"
    echo "3. Xfce"
    echo "4. Cinnamon"
    echo "5. MATE"
    echo "6. LXQt"
    echo "7. Budgie"
    echo "8. Unity (if available)"
    echo "9. Other (specify your choice)"
    echo "0. Exit"
}

# Function to read user input
function read_choice() {
    read -p "Enter your choice (0-9): " choice
}

# Function to handle desktop environment selection
function select_desktop_environment() {
    while true; do
        read_choice

        case $choice in
            0)
                echo "Exiting..."
                exit 0
                ;;
            1)
                echo "You chose GNOME."
                break
                ;;
            2)
                echo "You chose KDE Plasma."
                break
                ;;
            3)
                echo "You chose Xfce."
                break
                ;;
            4)
                echo "You chose Cinnamon."
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

#Funtion to handle file system selection
function select_fileystem() {
    while true; do
        
        read_fschoice

        case $choice in
            0)
                echo "Exiting..."
                exit 0
                ;;
            1)
                echo "You chose ext3."
                break
                ;;
            2)
                echo "You chose ext4."
                break
                ;;
            3)
                echo "You chose btrfs."
                break
                ;;
            *)
                echo "Invalid choice. Please enter a number between 0 and 3."
                ;;
        esac

        ch_File_SystemMenu
    done
}


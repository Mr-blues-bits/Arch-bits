# Arch-bits [WIP].
# Script for dualboot even multiboot. Will not touch existing system unless choose to.

[UPDATES]
---> SERVICE MODE AND OTHER MINOR ERROR AND FIXES.....

30 AUGUST, 2023
 .   1. Supported deskto env: GNOME, KDE PLASMA, CINNAMON , XFCE, MATE or even continue without installing any.
 .   2. Nvidia support added.
 .   3. In service mode you can chroot into any existing installation and make changes as desired.
 .   4. Automatically detect and mount all btrfs subvolumes for easy chroot aka. SERVICE MODE
 .   5. User is asked about each and every step in Service mode.
 
---> SUPPORT FOR BTRFS and NVIDIA ADDED. 19th August, 2023

***This script only formats chosen partitions. If dual booting do not install grub when asked...***

**use cfdisk to partition your disk**

Read paritioning section for partition details.

How to use this script:

boot from arch install cd and at prompt:

1. connect to internet if not connected
2. pacman -Sy git
3. git clone https://github.com/mr-blues-bits/arch-bits
4. cd arch-bits
5. ./start.sh
   

if you get error and file is not executeable run:

>chmod +x *.sh

the run script:
./start.sh

1. you will be asked to select your target disk.
2. then you will be asked to choose **ROOT/SYSTEM** partition.
3. then you will be asked to choose **SWAP** partition.
4. then you will be asked to choose **BOOT/EFI** partition.
5. then you have to choose your desired **ROOT/SYSTEM** filesystem eg: btrfs,ext4 or ext3.
6. Then you will be asked to choose to continue to install **base system**.
7. Next you will be asked to install GRUB. ***Choose No if you want to dual boot or have GRUB already setup. Install GRUB if you are dual booting with windows and GRUB is not already installed.***
8. Choose your desktop Environment. KDE, Cinnamon and GNOME supported atm. Other options have no script actions set.
9. Script will atomatically detect and install your graphics card.
10. DONE. Reboot and enjoy!


***####IMPORTANT FOR NVIDIA OPTIMUS LAPTOPS########***

If you end up on black screen.

reboot to boot menu

on grub menu press e and go into edit mode

at the line where it says linux bla bla stuff at the end type 
> nouveau.modeset=0

now press f10 to boot

NOTE: 

1. I HAVE TESTED THIS SCRIPT IN VIRTUAL MATCHINE AND ALSO ON REAL HARDWARE. IT WORKED FINE AS EXPECTED.
2. IF YOF FIND ERROR PLEASE DO SUGGUEST EDIT.
3. HIGHLY RECOMMENDED TO USE IN VM TO GET USE TO ARCH INSTALLATION
4. To install desktop env run pacman -S plasma/gnome/etc what ever you like.
5. for nvidia after first reboot run:


**READ BELOW ONLY FOR KNOWLEDGE**

In this example we will install kde plasma and sddm. for gnome/cinnamon use gnome/cinnamon lightdm

  pacman -S plasma sddm nvidia xorg-xrandr
  
  before reboot enable sddm
  
  systemctl enable sddm
  
  reboot and done. 

**++++++++ Partitions +++++++++++++++++**

use cfdisk to make partitions

eg:

boot partition 300MB to 1GB

swap partition (optional but recommended) 2GB or any size you like

for root system 30GB to anysize

++++Formating partitions if required.++++ 

run this command to find your about disk ids:

lsblk  

Boot partition:

mkfs.fat -F 32 /dev/yourBootdiskid

Swap Parition:

mkswap /dev/yourSwapdiskid

swapon /dev/yourSwapdiskid

root/system parition: use ext4 or btrfs

mkfs.ext4 /dev/yourRootdiskid

if you like btrfs use:

mkfs.btrfs /dev/yourRootdiskid 
~~

when you are done with this run Base.sh and follow onscreen instruction to finish installation.










# Arch-bits work in progress. 

SUPPORT FOR BTRFS ADDED. 19th August, 2023
This script has no disk formating commands.
use cfdisk to partition your hard disk.

Read paritioning section for partition details.

How to use this script:

boot from arch install cd and at prompt:

1. connect to internet if not connected
2. pacman -Sy git
3. git clone https://github.com/mr-blues-bits/arch-bits
4. cd arch-bits
5. ./Base.sh

if you get error and file is not execute able then run:

chmod +x *.sh

the run script:
./Base.sh

NOTE: 

1. I HAVE TESTED THIS SCRIPT IN VIRTUAL MATCHINE AND ALSO ON REAL HARDWARE. IT WORKED FINE AS EXPECTED.
2. IF YOF FIND ERROR PLEASE DO SUGGUEST EDIT.
3. HIGHLY RECOMMENDED TO USE IN VM FIRM TO GET USE TO ARCH INSTALLATION
4. To install desktop env run pacman -S plasma/gnome/etc what ever you like.
5. for nvidia after first reboot run:

In this example we will install kde plasma and sddm. for gnome/cinnamon use gnome/cinnamon lightdm

  pacman -S plasma sddm nvidia xorg-xrandr
  
  before reboot enable sddm
  
  systemctl enable sddm
  
  reboot and done. 

++++++++Partitions+++++++++++++++++

use cfdisk to make partitions

eg:

boot partition 300MB to 1GB

swap partition (optional but recommended) 2GB or any size you like

for root system 30GB to anysize

++++formating++++

run this command to find your about disk ids:

lsblk  

Boot partition:

mkfs.fat -F 32 /dev/yourBootdiskid

Swap Parition:

mkswap /dev/yourSwapdiskid

swapon /dev/yourSwapdiskid

root/system parition: use ext4 or btrfs

mkfs.ext4 /dev/yourRootdiskid

if you like btrfs use(not working atm):

mkfs.btrfs /dev/yourRootdiskid 

when you are done with this run Base.sh and follow onscreen instruction to finish installation.


####IMPORTANT FOR NVIDIA OPTIMUS LAPTOPS########
make sure to install nvidia and xorg-xrandr package along with plasma/gnome or what every desktop you like.
if you end up on black screen.
reboot to boot menu
on grub menu press e and go into edit mode
at the line where it says linux bla bla stuff at the end type nouveau.modeset=0 and press f10 to boot







# Arch-bits

WORK IN PROGRESS

This script has no disk formating commands.
use cfdisk to partition your hard disk.

Read paritioning section for partition details.

How to use this script:

boot from arch install cd and at prompt:

1. connect to internet if not connected
2. pacman -S git
3. git clone https://github.com/mr-blues-bits/arch-bits
4. cd arch-bits
5. ./Base.sh

if you get error and file is not execute able then run:

chmod +x Base.sh

the run script:
./Base.sh

++++++++Partitions+++++++++++++++++
use cfdisk to make partitions
eg.
boot partition 300MB to 1GB 
swap partition (optional but recommended) 2GB or any size you like
for root system 30GB to anysize

++++formating++++
run this command to find your disk ids:
lsblk  

Boot partition:
mkfs.fat -F 32 /dev/yourdiskid

Swap Parition:
mkswap /dev/yourswapdiskid
swapon /dev/yourswapdiskid

root/system parition: use ext4 or btrfs
mkfs.ext4 /dev/yourrootdiskid
if you like btrfs use:
mkfs.btrfs /dev/yourrootdiskid

when you are done with this run Base.sh and follow onscreen instruction to finish installation.






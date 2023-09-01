#!/bin/bash


    logfile=""
    diskSel=""
    root_part=""
    swap_part=""
    boot_part=""
    disk=""
    pkgQue=""
    stage1_vars_set=true
    Runcfdisk=false
    InServiceMode=false
    final_str=""
    nvidia_bol=false
    nvidia_str=""
    gpu_str=""
    de_str=""
    de_service=""
    hostname=""
    usrName=""
    sep_str=","
    #change this for your own kernel
    kernelStr="linux-zen"
    #Edit pkgQue to add your own packages:
    pkgQue="networkmanager base base-devel grub efibootmgr $kernelStr $kernelStr-headers linux-firmware avahi xdg-user-dirs xdg-utils nfs-utils bash-completion reflector iwd sof-firmware git nano pacman-contrib curl ntfs-3g"
    logfile="Installed-At:-$(date +'%Y-%m-%d_%H-%M-%S').log"
	
 echo "Our pkgque: $pkgQue"
 script -c "./single.sh" mylog.log

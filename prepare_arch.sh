#!/bin/bash

# HOST
# if on a blank arch installation execute arch_prep()
prep_arch() {
    sudo passwd
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacman-key --refresh-keys

    #echo "127.0.0.1 localhost" >> /etc/hosts
    #echo 'DISPLAY="localhost:10.0"' >> /etc/environment
    
    sudo cp docker/sshd_conf /etc/ssh/sshd_conf
    sudo cp docker/pacman.conf /etc/pacman.conf

    sudo pacman --noconfirm -Syu
    sudo pacman -S --noconfirm linux-headers base-devel lib32-libxtst libsm libxrender python youtube-dl ffmpeg xorg-xinit xorg-xhost xorg-xauth xorg-xclock
}

prep_arch
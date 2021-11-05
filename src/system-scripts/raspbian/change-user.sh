#!/usr/bin/env bash

_raspi_change_user() {
    local old_user="$1";
    local user="$2";
    sudo adduser "$user";
    sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi "$user"
    sudo rsync -avz "/home/$old_user/" "/home/$user";
}


#!/usr/bin/env bash

_raspi_change_user() {
    local user="$1";
    sudo adduser "$user";
    sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,gpio,i2c,spi "$user"
}

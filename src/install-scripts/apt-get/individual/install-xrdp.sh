#!/usr/bin/env bash

__install_xrdp() {
    local __apt_update="0";
    local __apt_upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                __apt_update="1";
                shift;;

            --upgrade)
                __apt_upgrade="1";
               shift;;
        esac
    done

    if [ "$__apt_update" = true ]; then sudo apt-get update; fi
    if [ "$__apt_upgrade" = true ]; then sudo apt-get upgrade; fi

    sudo apt-get install -y xrdp;

    if ! command -v xrdp > /dev/null; then
        echo "Unknown error occurred. xrdp may have failed. 'eval command -v xrdp': $(command -v xrdp)" >&2;
        exit 1;
    fi

    if ! sudo systemctl status xrdp | grep -qoE 'Active: active \(running\).*';  then
        sudo systemctl enable xrdp;
        sudo systemctl start xrdp;
        sudo systemctl status xrdp;
    fi

    exit "$?";
}

__install_xrdp "$@";

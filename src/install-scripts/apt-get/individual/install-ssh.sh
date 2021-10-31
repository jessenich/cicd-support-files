#!/usr/bin/env bash

__install_docker() {
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

    sudo apt install ssh;

    if ! which ssh > /dev/null; then
        echo "Unknown error occurred. Docker installation not detected. which docker: $(which docker)" >&2;
        exit 1;
    fi

    if ! sudo systemctl status ssh | grep -qoE 'Active: active \(running\).*';  then
        sudo systemctl enable --now ssh;
        sudo systemctl start ssh;
    fi
}

__install_docker "$@";

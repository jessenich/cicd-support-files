#!/usr/bin/env bash

__install_driver() {
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

    if [ -d "$HOME/Development/repos/github/cilynx/" ]; then
        rm -rf "$HOME/Development/repos/github/cilynx/";
    fi

    sudo apt install build-essential dkms git;
    mkdir -p "$HOME/Development/repos/github/cilynx"
    git clone https://github.com/cilynx/rtl88x2bu "$HOME/Development/repos/github/cilynx/rtl88x2bu"
    cd "$HOME/Development/repos/github/cilynx/rtl88x2bu" && \
    VER=$(sed -n 's/\PACKAGE_VERSION="\(.*\)"/\1/p' dkms.conf) && \
    sudo rsync -rvhP "$HOME/Development/repos/github/cilynx/rtl88x2bu" "/usr/src/rtl88x2bu-${VER}" && \
    sudo dkms add -m rtl88x2bu -v "${VER}" && \
    sudo dkms build -m rtl88x2bu -v "${VER}" && \
    sudo dkms install -m rtl88x2bu -v "${VER}" && \
    sudo modprobe 88x2bu;
}

__install_driver "$@";

#!/usr/bin/env bash

__install_lazygit() {
    local __apt_upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --upgrade)
                __apt_upgrade="1";
               shift;;
        esac
    done

    if [ "$__apt_upgrade" = true ]; then sudo apt-get upgrade; fi

    sudo add-apt-repository ppa:lazygit-team/release;
    sudo apt-get update;
    sudo apt-get install -y lazygit;

    if ! command -v lazygit > /dev/null; then
        echo "Unknown error occurred. lazygit installation not detected. which lazygit: $(command -v executable_name)" >&2;
        exit 1;
    fi

}

__install_lazygit "$@"

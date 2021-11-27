#!/usr/bin/env bash

__install-ubuntu-restricted-extras() {

    if [ "$(eval cat /etc/lsb-release | head -n1)" != "Ubuntu" ]; then
        echo "Script is only valid on Ubuntu distributions." >&2;
        exit 1;
    fi

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

    sudo apt-get install -y ubuntu-restricted-extras;

    if ! command -v cabextract > /dev/null; then
        echo "Unknown error occurred. ubuntu-restricted-extras installation not detected. which cabextract: $(which cabextract)" >&2;
        exit 1;
    fi

}

__install_ubuntu-restricted-extras "$@"

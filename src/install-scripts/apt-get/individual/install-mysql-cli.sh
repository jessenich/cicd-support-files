#!/usr/bin/env bash

__install_mycli() {
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

    sudo apt-get install -y mycli;

    if ! command -v mycli > /dev/null; then
        echo "Unknown error occurred. mycli installation not detected. which mycli: $(command -v mycli)" >&2;
        exit 1;
    fi

}

__install_mycli "$@"

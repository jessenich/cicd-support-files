#!/usr/bin/env bash

__install_wine-fe-playonlinux() {
    local update="0";
    local upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                update="1";
                shift;;

            --upgrade)
                upgrade="1";
               shift;;
        esac
    done

    if [ "$update" = true ]; then sudo zypper update -y; fi
    if [ "$upgrade" = true ]; then sudo zypper upgrade -y; fi

    sudo zypper install -y PlayOnLinux;

    if ! command -v PlayOnLinux > /dev/null; then
        echo "Unknown error occurred. wine-fe-playonlinux installation not detected. which PlayOnLinux: $(command -v PlayOnLinux)" >&2;
        exit 1;
    fi

}

__install_wine-fe-playonlinux "$@"

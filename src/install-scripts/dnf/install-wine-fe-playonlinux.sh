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

    if [ "$update" = true ]; then sudo dnf update; fi
    if [ "$upgrade" = true ]; then sudo dnf upgrade; fi

    sudo dnf install playonlinux;

    if ! command -v wine-fe-playonlinux > /dev/null; then
        echo "Unknown error occurred. wine-fe-playonlinux installation not detected. which playonlinux: $(command -v playonlinux)" >&2;
        exit 1;
    fi

}

__install_wine-fe-playonlinux "$@"

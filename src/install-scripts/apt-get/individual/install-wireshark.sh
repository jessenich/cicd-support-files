#!/usr/bin/env bash

__install_wireshark() {
    local __apt_update="0";
    local __apt_upgrade="0";
    local __docs=false;
    local __cli=false;

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                __apt_update="1";
                shift;;

            --upgrade)
                __apt_upgrade="1";
               shift;;

            --docs)
                __docs=true;
                shift;;

            --cli)
                __cli=true;
                shift;;
        esac
    done

    if [ "$__apt_update" = true ]; then sudo apt-get update; fi
    if [ "$__apt_upgrade" = true ]; then sudo apt-get upgrade; fi

    sudo apt-get install -y wireshark;

    if ! command -v wireshark > /dev/null; then
        echo "Unknown error occurred. wireshark installation not detected. which wireshark: $(command -v wireshark)" >&2;
        exit 1;
    fi

    if [ "$__docs" = true ]; then

    fi

}

__install_wireshark "$@"

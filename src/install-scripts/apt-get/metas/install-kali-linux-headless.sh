#!/usr/bin/env bash

__install_kali-linux-headless() {
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

    if [ "$update" = true ]; then
        echo "Updating package sources...";
        sudo apt-get update;
        echo "Done."

        if [ "$upgrade" = true ]; then
            echo "Upgrading packages...";
            sudo apt-get upgrade;
            echo "Done."
        fi
    fi

    if ! grep -o http://http.kali.org/kali /etc/apt/sources.list >/dev/null; then
        echo "Adding Kali mirror to sources.list"
        echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
        echo "Updating package sources...";
        sudo apt-get update;
    fi

    echo "Installing kali-linux-headless package";
    sudo apt-get install -y kali-linux-headless;

    if ! command -v kali-linux-headless >/dev/null; then
        echo "Unknown error occurred. kali-linux-headless installation not detected. which nmap: $(command -v nmap)" >&2;
        exit 1;
    fi

}

__install_kali-linux-headless "$@"

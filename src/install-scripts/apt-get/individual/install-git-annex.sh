#!/usr/bin/env bash

__install_git_annex() {
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

            --rclone-extension)
                local rclone_ext=true;
                shift;;
        esac
    done

    if [ "$__apt_update" = true ]; then sudo apt-get update; fi
    if [ "$__apt_upgrade" = true ]; then sudo apt-get upgrade; fi

    sudo apt-get install -y git-annex;
    if $? -eq 0; then
        sudo apt-get install -y git-annex-remote-rclone
    fi

    if ! command -v git-annex > /dev/null; then
        echo "Unknown error occurred. git-annex installation not detected. which git-annex: $(command -v git-annex)" >&2;
        exit 1;
    fi

    if ! command -v git-annex-remote-rclone > /dev/null; then
        echo "Unknown error occurred. git-annex-remote-rclone installation not detected. which git-annex-remote-rclone: $(command -v git-annex-remote-rclone)" >&2;
        exit 1;
    fi

}

__install_git_annex "$@"

#!/usr/bin/env bash

__install_agent_transfer() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                local update=true;
                shift;;

            --upgrade)
                local upgrade=true;
               shift;;
        esac
    done

    if [ "$update" = true ]; then sudo apt-get update; fi
    if [ "$upgrade" = true ]; then sudo apt-get upgrade; fi

    sudo apt-get install -y agent-transfer;

    if ! command -v agent-transfer > /dev/null; then
        echo "Unknown error occurred. agent-transfer installation not detected. which agent-transfer: $(command -v agent-transfer)" >&2;
        exit 1;
    fi

}

__install_agent_transfer "$@"

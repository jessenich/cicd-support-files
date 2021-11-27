#!/usr/bin/env bash

function install-lazygit() {
    local platform;
    platform="$(uname)";
    if [[ "$platform" = *Mac* ]]; then
        echo "MacPorts install scripts are not supported on ${platform}(s)." >&2;
        return 1;
    else
        sudo port install lazygit
        return 0;
    fi
}

install-lazygit "$@";

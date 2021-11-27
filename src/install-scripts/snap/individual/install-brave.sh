#!/usr/bin/env bash

if command -v brave >/dev/null; then
    echo "brave already installed at $(command -v brave), see 'snap help refresh'" >&2;
else
    sudo snap install brave >/dev/null;
    echo "Finished installing brave..." >&2;
fi

exit 0;

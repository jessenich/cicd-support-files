#!/usr/bin/env bash

if command -v vlc >/dev/null; then
    echo "vlc already installed at $(command -v vlc), see 'snap help refresh'" >&2;
else
    sudo snap install vlc >/dev/null;
    echo "Finished installing vlc..." >&2;
fi

exit 0;

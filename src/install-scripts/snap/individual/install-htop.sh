#!/usr/bin/env bash

if command -v htop >/dev/null; then
    echo "htop already installed at $(command -v htop), see 'snap help refresh'" >&2;
else
    sudo snap install htop >/dev/null;
    echo "Finished installing htop..." >&2;
fi

exit 0;

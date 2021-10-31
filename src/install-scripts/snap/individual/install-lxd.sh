#!/usr/bin/env bash

if command -v lxd >/dev/null; then
    echo "lxd already installed at $(command -v lxd), see 'snap help refresh'" >&2;
else
    sudo snap install lxd >/dev/null;
    echo "Finished installing lxd..." >&2;
fi

exit 0;

#!/usr/bin/env bash

if command -v libre-office >/dev/null; then
    echo "libre-office already installed at $(command -v libre-office), see 'snap help refresh'" >&2;
else
    sudo snap install libre-office >/dev/null;
    echo "Finished installing libre-office..." >&2;
fi

exit 0;

#!/usr/bin/env bash

if command -v discord >/dev/null; then
    echo "discord already installed at $(command -v discord), see 'snap help refresh'" >&2;
else
    sudo snap install discord >/dev/null;
    echo "Finished installing discord..." >&2;
fi

exit 0;

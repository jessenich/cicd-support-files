#!/usr/bin/env bash

if command -v librepcb >/dev/null; then
    echo "librepcb already installed at $(command -v librepcb), see 'snap help refresh'" >&2;
else
    sudo snap install librepcb >/dev/null;
    echo "Finished installing librepcb..." >&2;
fi

exit 0;

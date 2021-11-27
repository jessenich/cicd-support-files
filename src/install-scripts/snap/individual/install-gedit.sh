#!/usr/bin/env bash

if command -v gedit >/dev/null; then
    echo "gedit already installed at $(command -v gedit), see 'snap help refresh'" >&2;
else
    sudo snap install gedit >/dev/null;
    echo "Finished installing gedit..." >&2;
fi

exit 0;

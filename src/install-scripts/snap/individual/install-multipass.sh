#!/usr/bin/env bash

if command -v multipass >/dev/null; then
    echo "multipass already installed at $(command -v multipass), see 'snap help refresh'" >&2;
else
    sudo snap install multipass >/dev/null;
    echo "Finished installing multipass..." >&2;
fi

exit 0;

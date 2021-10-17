#!/usr/bin/env bash

if command -v teams >/dev/null; then
    echo "teams already installed at $(command -v teams), see 'snap help refresh'" >&2;
else
    sudo snap install teams >/dev/null;
    echo "Finished installing teams..." >&2;
fi

exit 0;

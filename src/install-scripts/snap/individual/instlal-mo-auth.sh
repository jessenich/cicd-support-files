#!/usr/bin/env bash

if command -v moauth >/dev/null; then
    echo "moauth already installed at $(command -v moauth), see 'snap help refresh'" >&2;
else
    sudo snap install moauth >/dev/null;
    echo "Finished installing moauth..." >&2;
fi

exit 0;

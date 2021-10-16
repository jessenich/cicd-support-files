#!/usr/bin/env bash

if which onefetch >/dev/null; then
    echo "onefetch already installed at $(which onefetch), see 'snap help refresh'" >&2;
else
    sudo snap install onefetch >/dev/null;
    echo "Finished installing onefetch..." >&2;
fi

exit 0;


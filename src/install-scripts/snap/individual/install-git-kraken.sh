#!/usr/bin/env bash

if command -v git-kraken >/dev/null; then
    echo "git-kraken already installed at $(command -v git-kraken), see 'snap help refresh'" >&2;
else
    sudo snap install git-kraken >/dev/null;
    echo "Finished installing git-kraken..." >&2;
fi

exit 0;


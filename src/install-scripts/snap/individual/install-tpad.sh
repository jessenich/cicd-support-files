#!/usr/bin/env bash

if command -v tpad >/dev/null; then
    echo "tpad already installed at $(command -v tpad), see 'snap help refresh'" >&2;
else
    sudo snap install tpad >/dev/null;
    echo "Finished installing tpad..." >&2;
fi

exit 0;

#!/usr/bin/env bash

if command -v storage-explorer >/dev/null; then
    echo "storage-explorer already installed at $(command -v storage-explorer), see 'snap help refresh'" >&2;
else
    sudo snap install storage-explorer >/dev/null;
    echo "Finished installing storage-explorer..." >&2;
fi

exit 0;

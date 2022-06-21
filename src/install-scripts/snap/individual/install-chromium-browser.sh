#!/usr/bin/env bash

if which chromium >/dev/null; then
    echo "chromium already installed at $(which chromium), see 'snap help refresh'" >&2;
else
    sudo snap install chromium >/dev/null;
    echo "Finished installing chromium..." >&2;
fi

exit 0;

#!/usr/bin/env bash

if command -v httpie >/dev/null; then
    echo "httpie already installed at $(command -v httpie), see 'snap help refresh'" >&2;
else
    sudo snap install httpie >/dev/null;
    echo "Finished installing httpie..." >&2;
fi

exit 0;

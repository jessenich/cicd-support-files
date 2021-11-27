#!/usr/bin/env bash

if command -v bashtop >/dev/null; then
    echo "bashtop already installed at $(command -v bashtop), see 'snap help refresh'" >&2;
else
    sudo snap install bashtop >/dev/null;
    echo "Finished installing bashtop..." >&2;
fi

exit 0;

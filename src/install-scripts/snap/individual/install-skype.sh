#!/usr/bin/env bash

if command -v skype >/dev/null; then
    echo "skype already installed at $(command -v skype), see 'snap help refresh'" >&2;
else
    sudo snap install skype >/dev/null;
    echo "Finished installing skype..." >&2;
fi

exit 0;

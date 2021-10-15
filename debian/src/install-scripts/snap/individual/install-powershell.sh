#!/usr/bin/env bash

if which powershell >/dev/null; then
    echo "powershell already installed at $(which powershell)";
else
    sudo snap install powershell >/dev/null;
    echo "Finished installing powershell...";
fi

exit 0;

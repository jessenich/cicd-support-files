#!/usr/bin/env bash

if command -v powershell >/dev/null; then
    echo "powershell already installed at $(command -v powershell)";
else
    sudo snap install powershell >/dev/null;
    echo "Finished installing powershell...";
fi

exit 0;

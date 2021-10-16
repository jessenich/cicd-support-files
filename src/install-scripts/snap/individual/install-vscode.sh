#!/usr/bin/env bash

if which code >/dev/null; then
    echo "VSCode already installed at $(which code)";
else
    sudo snap install code;
fi

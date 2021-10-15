#!/usr/bin/env bash

if which lincode-cli >/dev/null; then
    echo "lincode-cli already installed at $(which lincode-cli)";
else
    sudo snap install lincode-cli;
fi

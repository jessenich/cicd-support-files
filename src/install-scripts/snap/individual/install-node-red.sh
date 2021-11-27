#!/usr/bin/env bash

if which node-red >/dev/null; then
    echo "node-red already installed at $(which node-red)";
else
    sudo snap install node-red >/dev/null;
    echo "Finished installing node-red...";
fi

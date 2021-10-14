#!/usr/bin/env bash

if which dotnet-sdk >/dev/null; then
    echo "dotnet-sdk already installed at $(which dotnet-sdk)";
else
    sudo snap install dotnet-sdk --classic >/dev/null;
    echo "Finished installing dotnet-sdk...";
fi

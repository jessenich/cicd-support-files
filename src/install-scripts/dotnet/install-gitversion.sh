#!usr/bin/env bash

if dotnet tool list -g | grep -q "gitversion.tool"; then
    echo "GitVersion already installed";
else
    echo "Installing GitVersion";
    dotnet tool install --global gitversion.tool;
    echo "Done.";
fi

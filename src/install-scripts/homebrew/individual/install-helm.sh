#!/usr/bin/env bash

if ! command -v brew; then
    echo "Homebrew is required to run this script" >&2;
    exit 1;
fi

brew update;
brew install helm;

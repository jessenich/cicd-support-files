#!/usr/bin/env bash

if ! command -v go; then
    echo "Go is required to install manually." >&2;
fi

git clone https://github.com/jesseduffield/lazygit.git
cd lazygit || exit 1;
go install

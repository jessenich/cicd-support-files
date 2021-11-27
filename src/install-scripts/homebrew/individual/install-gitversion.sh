#!/usr/bin/env bash

# shellcheck disable=SC2016

if ! command -v brew; then
    echo "Homebrew is required to run this script" >&2;
    echo "Run the following comand to instlal Homebrew. https://brew.sh" >&2;
    echo '   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)' >&2;
    exit 1;
fi

# Always run brew update prior to installing a package.
echo 'Running brew update prior to install'
brew update;
echo "Installing GitVersion..."
brew install gitversion;
echo "Done. Invoke with 'gitversion'";
exit 0;

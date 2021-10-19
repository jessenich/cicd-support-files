#!/usr/bin/env bash

npm install --global yarn;
if which yarnpkg && ! which yarn; then
    ln -s "$(dirname "$(which yarnpkg)")/yarn" "$(dirname "$(which yarnpkg)")"
fi

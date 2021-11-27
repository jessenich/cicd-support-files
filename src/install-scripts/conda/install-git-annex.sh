#!/usr/bin/env bash

function install-git-annex() {
    local alldeps="$1";
    if [ "$alldeps" = true ]; then
        conda install -c conda-forge git-annex=*=alldep*
    else
        conda install -c conda-forge git-annex
    fi
}

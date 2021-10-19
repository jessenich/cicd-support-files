#!/usr/bin/env bash

brew update;

# Debian/Ubuntu
if [[ "$(uname -a)" = Linux* ]]; then
    brew install yq;

# MacOS
elif [[ "$(uname -a)" = Darwin* ]]; then
    brew install \
        bison \
        brotli \
        autoconf \
        autoconf-archive \
        automake \
        azcopy \
        azure-cli \
        make \
        minikube \
        mono \
        nano \
        nanorc \
        nmap \

fi

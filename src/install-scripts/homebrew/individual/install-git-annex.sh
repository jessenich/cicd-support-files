#!/usr/bin/env bash


function install-git-annex() {

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            --from-source)
                local from_source=true;
                shift;;
        esac
    done

    brew update;

    if [ "$from_source" = false ]; then
        brew install git-annex;
    else
        brew install \
            haskell-platform \
            git \
            ossp-uuid \
            md5sha1sum \
            coreutils \
            gnutls \
            libidn \
            gsasl \
            pkg-config \
            libxml2

        brew link libxml2 --force
        cabal update
        mkdir -p "$HOME/bin"
        PATH="$HOME/bin:$PATH"
        PATH="$HOME/.cabal/bin:$PATH"

        cabal install c2hs --bindir="$HOME/bin"
        cabal install gnuidn
        cabal install git-annex --bindir="$HOME/bin"
    fi
}

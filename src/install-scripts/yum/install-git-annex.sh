#!/usr/bin/env bash

#shellcheck disable=SC2154,SC2034

install_git_annex() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                local update=true;
                shift;;

            --upgrade)
                local upgrade=true;
                shift;;
        esac
    done

    if [ "$update" = true ]; then sudo yum update -y; fi
    if [ "$upgrade" = true ]; then sudo yum upgrade -y; fi

    eval 'cat /etc/os-release';

    sudo yum install git;

    ## Note: You can't just use cabal install git-annex, because Fedora does not yet ship ghc 7.4.
    if $VERSION_ID -gt 13 && $VERSION_ID -lt 16; then
        sudo yum install git ghc cabal-install
        git clone git://git-annex.branchable.com ./git-annex
        cd git-annex || exit 1;
        git checkout ghc7.0
        cabal update
        cabal install --only-dependencies
        cabal configure
        cabal build
        cabal install --bindir="$HOME/bin"
    else
        sudo yum install libxml2-devel gnutls-devel libgsasl-devel ghc cabal-install happy alex libidn-devel
        cabal update
        cabal install --bindir="$HOME/bin" c2hs
        cabal install --bindir="$HOME/bin" git-annex
    fi
}

install_git_annex "$@"

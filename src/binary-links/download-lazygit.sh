#!/usr/bin/env bash

_dl_lazygit_main() {
    local version="0.30.1";
    local platform="Darwin";
    local arch="x86_x64";
    local format="tar.gz";
    local source_only=false;

    while [ "$#" -gt 0 ]; do
        case "$1" in
            -v | --version)
                version="$2";
                shift 2;;

            -p | --platform)
                platform="$2";
                shift 2;;

            -a | --architecture)
                arch="$2";
                shift 2;;

            -f | --format)
                format="$2";
                shift 2;;

            --source-only)
                source_only=true;
                shift;;
        esac
    done

    local url;
    if [ "$source_only" = true ]; then
        url="https://github.com/jesseduffield/lazygit/archive/refs/tags/v${version}.${format}";
    else
        url="https://github.com/jesseduffield/lazygit/releases/download/v$version/lazygit_${version}_${platform}_${arch}.${format}";
    fi

    curl -sSLO "$url";
}

alias download-lazygit-source-only-zip='_dl_lazygit_main --source-only -f zip'
alias download-lazygit-source-only-targz='_dl_lazygit_main --source-only -f tar.gz'

alias download-lazygit-macos-amd64='_dl_lazygit_main -v 0.30.1 -p darwin -a x86_x64 -f tar.gz'
alias download-lazygit-macos-arm64='_dl_lazygit_main -v 0.30.1 -p darwin -a arm64 -f tar.gz'

alias download-lazygit-freebsd-amd64='_dl_lazygit_main -v 0.30.1 -p freebsd -a x86_x64 -f tar.gz'
alias download-lazygit-freebsd-arm64='_dl_lazygit_main -v 0.30.1 -p freebsd -a amd64 -f tar.gz'
alias download-lazygit-freebsd-armv6='_dl_lazygit_main -v 0.30.1 -p freebsd -a armv6 -f tar.gz'
alias download-lazygit-freebsd-x86='_dl_lazygit_main -v 0.30.1 -p freebsd -a 32-bit -f tar.gz'

alias download-lazygit-linux-amd64='_dl_lazygit_main -v 0.30.1 -p linux -a x86_x64 -f tar.gz'
alias download-lazygit-linux-arm64='_dl_lazygit_main -v 0.30.1 -p linux -a amd64 -f tar.gz'
alias download-lazygit-linux-armv6='_dl_lazygit_main -v 0.30.1 -p linux -a armv6 -f tar.gz'
alias download-lazygit-linux-x86='_dl_lazygit_main -v 0.30.1 -p linux -a 32-bit -f tar.gz'

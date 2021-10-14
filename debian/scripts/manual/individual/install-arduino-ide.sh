#!/usr/bin/bash

# shellcheck disable=SC2154

echo "WIP..................." >&2;
exit 127;

__runtime_dir="${XDG_RUNTIME_DIR:-$HOME/.local/bin}";
__data_dir="${XDG_DATA_DIR}"
__version="1.8.16";

__download-arduino-package-file() {
    local download="${1:-"arduino-${__version}-linux64.tar.xz"}";
    local output_dir="${2:-/tmp}";

    curl --output_dir "/tmp" -O \
        "https://downloads.arduino.cc/arduino-ide/${download}" \
        -H 'authority: downloads.arduino.cc' \
        -H 'sec-ch-ua-platform: "Linux"' \
        -H 'upgrade-insecure-requests: 1' \
        -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36' \
        -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
        -H 'sec-fetch-site: same-site' \
        -H 'sec-fetch-mode: navigate' \
        -H 'sec-fetch-user: ?1' \
        -H 'sec-fetch-dest: document' \
        -H 'referer: https://www.arduino.cc/' \
        -H 'accept-language: en-US,en;q=0.9' && \
    echo "$output_dir/$download" || \
    echo "Download of '$download' failed.";
}

__unzip_beta_package() {
    local zipfile="$1";
    local installdir="${2:-"$__runtime_dir/Arduino/IDE/v2.0-beta"}";
    unzip -uoaqq "$zipfile" -d /tmp/Arduino/IDE/v2.0-beta;
    install -m 0700 -o "$USER" -t "$installdir"
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -i | --install-dir)
            __mkinstalldir "$2";
            shift 2;;

        *)
            shift;;
    esac
done

test -n "${__beta_file}" && \
    __file="${__beta_file}" || \
    __file="arduino-${__version}-linux64.tar.xz"

if [ "${__file}" = "${__beta_file}" ]; then
    unzip -uoaqq "/tmp/${__file}";
fi

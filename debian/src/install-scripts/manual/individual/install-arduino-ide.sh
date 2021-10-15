#!/usr/bin/bash

# shellcheck disable=SC2154

echo "WIP..................." >&2;
exit 127;



__arduino_parse_args() {
    local __version="1.8.16";
    local __download_path="$HOME/Downloads"
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -v | --version)
                __version="$2";
                shift 2;;

            -d | --download-path)
                __download_path="$2";
                shift 2;;

            *)
                echo "Unrecognized argument '$1'" >&2;
                exit 1;
        esac
    done



}

__download-arduino-tarball() {
    local download="${1:-"arduino-${__version:-1.8.16}-linux64.tar.xz"}";
    local output_dir="${2:-$HOME/Downloads}";

    curl -o "${output_dir}/${download}" \
        "https://downloads.arduino.cc/arduino-ide/${download}" \
        -H 'authority: downloads.arduino.cc' \
        -H 'sec-ch-ua-platform: "Linux"' \
        -H 'upgrade-insecure-requests: 1' \
        -H "user-agent: curl:$(curl --version); $SHELL" \
        -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
        -H 'sec-fetch-site: same-site' \
        -H 'sec-fetch-mode: navigate' \
        -H 'sec-fetch-user: ?1' \
        -H 'sec-fetch-dest: document' \
        -H 'referer: https://www.arduino.cc/' \
        -H 'accept-language: en-US,en;q=0.9';
    local exit_code="$?";
    if ((exit_code != 0)) && [ ! -e "${output_dir}/${download}" ]; then
        echo "Download of '$download' failed. Exiting with status code $exit_code" >&2;
        exit "$exit_code"
    fi

    echo "$output_dir/$download";
    exit 0;
}

__install_arduino_tarball() {
    if [ ! -e "$1" ]; then
        echo "File '$1' not found or file is corrupt." >&2;
        exit 1;
    fi

    local __dir_name;
    __dir_name="$(tar xf --overwrite --overwrite-dir "$1")";
    bash "${__dir_name/install.sh}";

}



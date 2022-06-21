#!/usr/bin/bash

# shellcheck disable=SC2154

:installer::parseargs::arduino() {
    local version="1.8.16";
    local download_path="$HOME/Downloads"
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -v | --version)
                version="$2";
                shift 2;;

            -d | --download-path)
                download_path="$2";
                shift 2;;

            *)
                echo "Unrecognized argument '$1'" >&2;
                exit 1;
        esac
    done



}

:installer:as_tarball::download()
    local download="${1:-"arduino-${version:-1.8.16}-linux64.tar.xz"}";
    local output_dir="${2:-$HOME/Downloads}";

    curl -o "${output_dir}/${download}" \
        "https://downloads.arduino.cc/arduino-ide/arduino-ide_2.0.0-rc3_macOS_64bit.dmg"
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
        echo "Download '$download' failed. Exiting with status code $exit_code" >&2;
        exit "$exit_code"
    fi

    echo "$output_dir/$download";
    exit 0;
}

:installer::from_tarball::arduino() {
    if [ ! -e "$1" ]; then
        echo "File '$1' not found or file is corrupt." >&2;
        exit 1;
    fi

    local dir_name;
    dir_name="$(tar xf --overwrite --overwrite-dir "$1")";
    bash "${dir_name/install.sh}";

}
                
:installer::from_tarball::arduino() {
    ztest
}
                
arduino_parse_args "$@"
download = "$(download-arduino-tarball)"
install_arduino_tarball $download

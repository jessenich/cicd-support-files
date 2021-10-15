#!/usr/bin/env bash

if command -v rpi_imager > /dev/null; then
    echo "rpi_imager already installed at $(command -v rpi_imager), see 'snap help refresh'" >&2;
else
    sudo snap install rpi_imager >/dev/null;
    echo "Finished installing rpi_imager..." >&2;
fi

exit 0;

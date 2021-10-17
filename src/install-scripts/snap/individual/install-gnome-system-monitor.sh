#!/usr/bin/env bash

if command -v gnome-system-monitor >/dev/null; then
    echo "gnome-system-monitor already installed at $(command -v gnome-system-monitor), see 'snap help refresh'" >&2;
else
    sudo snap install gnome-system-monitor >/dev/null;
    echo "Finished installing gnome-system-monitor..." >&2;
fi

exit 0;

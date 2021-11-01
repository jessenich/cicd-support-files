#!/usr/bin/env bash
# shellcheck disable=SC2002
if ! cat /etc/apt/apt.conf.d/00aptitude | tail -n 2 | grep -o 'Acquire::Languages "none";'; then
    echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/00aptitude >/dev/null;
fi

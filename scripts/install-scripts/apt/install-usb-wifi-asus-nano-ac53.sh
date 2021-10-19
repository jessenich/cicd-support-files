#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install build-essential dkms git
mkdir -p ~/Development/repos/github/cilynx
git clone https://github.com/cilynx/rtl88x2bu ~/Development/repos/github/cilynx
cd ~/Development/repos/github/cilynx || (echo "$HOME/Development/repos/github/cilynx not found" >&2 && exit 1);
VER=$(sed -n 's/\PACKAGE_VERSION="\(.*\)"/\1/p' dkms.conf)
sudo rsync -rvhP ./ "/usr/src/rtl88x2bu-${VER}"
sudo dkms add -m rtl88x2bu -v "${VER}"
sudo dkms build -m rtl88x2bu -v "${VER}"
sudo dkms install -m rtl88x2bu -v "${VER}"
sudo modprobe 88x2bu
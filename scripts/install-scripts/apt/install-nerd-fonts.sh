#!/usr/bin/env bash

curl -Lo nerd-fonts.tar.gz 'https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v2.1.0.tar.gz'
tar --xz -f 'nerd-fonts.tar.gz' --overwrite
sudo /bin/bash ./nerd-fonts/install.sh

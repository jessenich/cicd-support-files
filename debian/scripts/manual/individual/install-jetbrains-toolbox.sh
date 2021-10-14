#!/usr/bin/env bash

curl -sSLO https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.21.9712.tar.gz
tar xvzf jetbrains-toolbox-1.21.9712.tar.gz
mkdir -p "$HOME/bin/"
mv jetbrains-toolbox-1.21.9712/jetbrains-toolbox "$HOME/bin/jetbrains-toolbox.AppImage";
chmod a+x "$HOME/bin/jetbrains-toolbox.AppImage";

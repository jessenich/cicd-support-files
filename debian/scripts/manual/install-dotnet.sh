#!/usr/bin/env bash

__channel=5.0;
__pkg="sdk";

while [ "$#" -gt 0 ]; do
    case "$1" in
        -c | --__channel)
            __channel="$2";
            shift 2;;

        -r | --runtime | --no-sdk)
            # shellcheck disable=2034
            __pkg=runtime;
            shift;;

        -a | --aspnetcore)
            __asp=true;
            shift;;
    esac
done

eval "$(cat /etc/lsb-release)"

# shellcheck disable=SC2154
wget "https://packages.microsoft.com/config/ubuntu/$DISTRIB_RELEASEe/packages-microsoft-prod.deb" -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb


sudo apt-get install -y "dotnet-$__pkg-$__channel";

if [ -n "$__asp" ]; then
    sudo apt-get install -y "aspnetcore-runtime-$__channel"
fi

rm /tmp/packages-microsoft-prod.deb

dotnet tool install cake.tool --global
dotnet tool install dotnet-ef --global
dotnet tool install nuke.globaltool --global
dotnet tool install dotnet-script --global
https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20211009_Linux_64bit.zip

#!/usr/bin/env bash

channel=5.0;
pkg="sdk";
asp=true;

while [ "$#" -gt 0 ]; do
    case "$1" in
        -c | --channel)
            channel="$2";
            shift;;

        -r | --runtime | --no-sdk)
            sdk=false;
            shift;;

        -a | --aspnetcore)
            asp=true;
            shift;;
    esac
done

eval $(cat /etc/lsb-release)

wget "https://packages.microsoft.com/config/ubuntu/$DISTRIB_RELEASE/packages-microsoft-prod.deb" -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb


sudo apt-get install -y "dotnet-$pkg-$channel";

if [ "$pkg" != "sdk" ] && [ "$asp" ]; then
    sudo apt-get install -y "aspnetcore-runtime-$channel"
fi

rm /tmp/packages-microsoft-prod.deb

dotnet tool install cake.tool --global
dotnet tool install dotnet-ef --global
dotnet tool install nuke.globaltool --global
dotnet tool install dotnet-script --global
#!/usr/bin/env bash

sudo curl -fsSL -o 'azure-data-studio.tar.gz' 'https://go.microsoft.com/fwlink/?linkid=2170045';
sudo tar -C /usr/lib/ -xzf 'azure-data-studio.tar.gz' --overwrite;
sudo mv /usr/lib/azuredatastudio-linux-x64 /usr/lib/azure-data-studio
sudo ln -s /usr/lib/azure-data-studio/bin/azuredatastudio /usr/local/bin
sudo rm -f 'azure-data-studio.tar.gz'

echo "Azure Data Studio installed to /usr/lib, and linked to /usr/local/bin successfully." >&2
exit 0;

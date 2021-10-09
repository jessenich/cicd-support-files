#!/usr/bin/env bash

sudo apt-get autoremove protonvpn
rm -rf ~/.cache/protonvpn
rm -rf ~/.config/protonvpn

cat <'EOF'
Disable Kill Switch

The Kill Switch can be easily disabled from within the official Linux app, but this will not be possible if you uninstalled the app first without disabling the Kill Switch. This may result in your system being unable to access the internet. To remove the Kill Switch after the app has been uninstalled:
a) Identify ProtonVPN connection names by running the command:
nmcli connection show --active
This will display a list of all your system’s active connections.

b) Look for any connections with the pvpn- This usually includes pvpn-killswitch and pvpn-ipv6leak-protection, and may include pvpn-routed-killswitch. Delete all these connections using the following command:
nmcli connection delete [connection name]
For example:
nmcli connection delete pvpn-killswitch

c) Re-run the following command to verify that ProtonVPN connections have been deleted:
nmcli connection show --active

If any ProtonVPN connections remain, delete them as described above.
EOF

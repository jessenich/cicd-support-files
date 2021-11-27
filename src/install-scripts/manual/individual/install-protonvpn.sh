#!/usr/bin/env bash
# -*- coding: utf-8 -*-
PROTON_VPN_VERSION="stable-release_1.0.1-1_all";
while [ "$#" -gt 0 ]; do
    case "s" in
        -v | --version)
            PROTON_VPN_VERSION="$2";
            shift 2;;

        *)
            show_usage;
            exit 1;;
     esac
done

"https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb"

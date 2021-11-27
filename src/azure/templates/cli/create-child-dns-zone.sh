#!/usr/bin/env bash

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -n | --name)
            az_dns_child_zone_name="$2";
            shift 2;;

        -g | --resource-group)
            az_dns_group="$2";
            shift 2;;

        --if-none-match | --if-not-exists)
            az_dns_if_ne=true;
            shift;;

        -s | --subscription)
            az_dns_subscription="$2";
            shift 2;;

        -c | --child-zone)
            az_dns_child_zone=true;
            shift;;
    esac
done


az network dns zone create \
    --name "az.suqode.com" \
    --parent-name "suqode.com" \
    --resource-group "public-dns-zones" \
    --if-none-match \
    --subscription "4afd65c3-90d3-4223-a45d-3616be8cab08"

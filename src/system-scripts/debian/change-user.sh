#!/usr/bin/env bash

_chuser_parse_args() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -g | --group)
               local grps+=( "$2" );
               shft;;

            -u | --user)
                local user="$2";
                shift 2;;
        esac
    done

}

#!/usr/bin/env bash

print_usage() {
    cat <<-'EOF'

EOF
}

_igar_main() {



    while [ $# -gt 0 ]; do
        case "$1" in
            -d | --dir | --directory)
                local directory="$2";
                shift 2;;

            -n | --name)
                local name="$2";
                shift 2;;

            -i | --git-init)
                local git_init=false;
                shift;;

            -f | --force)
                local force_init=true;
                shift;;

            --)
                local passthru="$@";;

            *)
                echo "Unrecognized parameter '$1'" >&2;
                echo print_usage;
                exit 1;
        esac
    done

    if [ ! -d "$directory" ]; then
        mkdir -p "$directory";
    fi

    if $force_init; then
        rm -rf "$directory/.git";
    fi

    if [ ! -d "$directory/.git" ] && [ "$git_init" != false ]; then
        git init
    fi
}




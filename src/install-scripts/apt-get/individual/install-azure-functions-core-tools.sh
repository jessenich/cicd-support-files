
#!/usr/bin/env bash

__install_azure-functions-core-tools() {
    local update="0";
    local upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --allow-preview)
                local allow_preview=true;
                shift;;

            --interactive)
                local on_interactive_flag=-y;
                shift;;

            -v | --version)
                local version="$2";
                shift 2;;

            -n | --no-install-recommends)
                local install_recommends=--no-install-recommends;
                shift 1;;

            -u | --update)
                local update=true;
                shift;;

            -uu | --upgrade)
                local update=true
                local upgrade=true;
                shift;;

            --dry-run)
                local dry_run=true;
                shift;;

        esac
    done

    if [ "$allow_preview" != true ] && [ "$version" -gt 3 ]; then
        echo "Error: Only non preview versions of azure-functions-core-tools are allowed." 1>&2;
        exit 1;
    else
        echo "U"
    fi

    if [ "$update" = true ]; then sudo apt-get update; fi
    if [ "$upgrade" = true ]; then sudo apt-get upgrade; fi

    if [ -n "$version" ]; then
        local package=azure-functions-core-tools-2;
    else
        local package=azure-functions-core-tools-3;
    fi

    sudo apt-get install -y "$install_recommends" "$package";

    if ! command -v azure-functions-core-tools > /dev/null; then
        echo "Unknown error occurred. azure-functions-core-tools installation not detected. which executable_name: $(command -v executable_name)" >&2;
        exit 1;
    fi

}

__install_azure-functions-core-tools "$@"

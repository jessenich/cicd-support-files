#!/usr/bin/env bash

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install it and try again."
    exit 1
fi

__install_docker_plugin() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -d | --disable)
                local disable_arg="--disable";
                shift;;

            -a | --alias)
                local -r alias_arg="--alias $2";
                shift 2;;

            -g | --grant)
                local -r grant_arg="--grant-all-permissions";
                shift;;

            *)
                local -r plugin_name="$1";
                local -r plugin_version="$2";
                shift 2;

                if [[ -z "$plugin_name" ]]; then
                    echo "Missing plugin name."
                    exit 1
                fi

                if [[ -z "$plugin_version" ]]; then
                    echo "Missing plugin version."
                    exit 1
                fi

                if "$#" -gt 0; then
                    echo "Invalid argument: $1";
                    exit 1;
                else
                    break;
                fi
                ;;
        esac
    done

    docker plugin install "$grant_arg" "$alias_arg" "$disable_arg" "$plugin_name:$plugin_version"
}

install-elastic-logging-docker-plugin() {
    __install_docker_plugin -d -a elastic-logging -g "elastic/elastic-logging-plugin" "${1:-7.15.2}";
}

enable-elastic-logging-docker-plugin() {
    docker plugin enable elastic-logging;
}

install-sshfs-volume-docker-plugin() {
    __install_docker_plugin -d -a sshfs -g "vieux/sshfs" "${1:-latest}";
}

enable-ssfs-volume-docker-plugin() {
    docker plugin enable sshfs;
}


install-splunk-logging-docker-plugin() {
    __install_docker_plugin -d -a splunk-logging -g "splunk/docker-logging-plugin" "${1:-2.0.0}";
}

enable-splunk-logging-docker-plugin() {
    docker plugin enable splunk-logging;
}

main() {
    local -r command="$1";
    local -r plugin_name="$2";
    shift 2;

    if [[ "$command" != [Ii]nstall ]] && [[ "$command" != [Ee]nable ]]; then
        echo "Missing/Invalid command. 'install' or 'enable' allowed."
        exit 1
    fi

    if [[ -z "$plugin_name" ]]; then
        echo "Missing plugin name."
        exit 1
    fi

    case "$plugin_name" in
        elastic-logging | sshfs | splunk-logging)
            "$command-$plugin_name-docker-plugin" "$@";
            ;;
        *)
            echo "Invalid plugin: $plugin_name";
            exit 1;
            ;;
    esac
}

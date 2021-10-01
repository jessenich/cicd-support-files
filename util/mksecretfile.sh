#!/usr/bin/env bash

secret_type= ;
secret_service= ;
script_file_name= ;
script_dir_path= ;

read_token=false;
read_username=false;
read_secondary=false;

script_info() {
    script_file_name="${BASH_SOURCE[0]}"

    # resolve $script_file_name until the file is no longer a symlink
    while [ -h "$script_file_name" ]; do
    script_dir_path="$( cd -P "$( dirname "$script_file_name" )" && pwd )"
    script_file_name="$(readlink "$script_file_name")"

    # if $script_file_name was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    [[ $script_file_name != /* ]] && script_file_name="$DIR/$script_file_name"
    done

    script_dir_path="$( cd -P "$( dirname "$script_file_name" )" && pwd )"
}

show_usage() {
    cat <<-EOF
Usage:
    # Creates secret files for github. The target service must be the first argument
    $script_file_name --github jessenich ghp_d52beab3-ead6-4a8f-98af-a5ef87e9d218

    # The following will error. Interactively must be specified explicitly.
    $script_file_name --dockerhub

    # Creates the necessary dockerhub secret files interactively
    $script_file_name --dockerhub --read-username-std-in --read-token-std-in

    # Create Azure Resource Secret
    $script_file_name --azure resource_id secret_value_1 secret_value_2
EOF
}

parse_args() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -g | -gh | --github)
                secret_type="git-remote"
                secret_service="github";
                shift;;

            -dv | --devops | --azure-devops)
                secret_type="git-remote"
                secret_service="azdevops";
                shift;;

            -gl | --gitlab)
                secret_type="git-remote";
                secret_service="gitlab";
                shift;;

            -jb | --jetbrains-spaces)
                secret_type="git-remote"
                secret_service="jetbrains"
                shift;;

            -b | --bb | --bitbucket)
                secret_type="git-remote";
                secret_service="bitbucket";
                shift;;

            -d | -dh | --dockerhub)
                secret_type="docker-registry"
                secret_service="dockerhub";
                shift;;

            -acr | --azure-container-registry)
                secret_type="docker-registry";
                secret_service="azure-container-registry";
                shift;;

            -az | --azure | --azure-cloud)
                secret_type="cloud";
                secret_service="azure-cloud";
                shift;;

            -gcp | --google-cloud | --google-cloud-platform)
                secret_type="cloud";
                secret_service="google-cloud";
                shift;;

            -aws | --amazon | --amazon-web-services)
                secret_type="cloud";
                secret_service="aws-cloud"
                shift;;

            -j | --jira)
                secret_type="tasking"
                secret_service="jira_boards"
                shift;;

            --asana)
                secret_type="tasking";
                secret_service="asana"
                shift;;

            --read-token-std-in)
                read_token=true;
                shift;;

            --read-secondary-std-in)
                read_secondary=true;
                shift;;

            --read-username-std-in)
                read_username=true;
                shift;;

            --no-user | --no-email | --only-token | --only-token-secondary)
                no_user=true;
                shift;;

            *)
                # Secret values are positional
                # 1=username
                # 2=token
                # 3=optional secondary token (common for azure)
                if [ -z "$username" ]; then
                    username="$1";
                elif [ -z "$secret_value" ]; then
                    secret_value="$1";
                elif [ -z "$secondary_value" ]; then
                    secondary_value="$1";
                else
                    show_usage;
                    exit 1;
                fi
                break;;
        esac
    done
}

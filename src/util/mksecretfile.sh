#!/usr/bin/env bash

do_run=true;
log_level=2;
correlation_id=0;

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
USAGE:
    $script_file_name SERVICE_OPTION [PRIMARY] &| [SECONDARY] &| [TERTIARY]
    TUPLE_ELEMENT_X can be any value, each individual tuple element is stored within it's own secret
    file corresponding to the SERVICE_OPTION supplied.

EXAMPLES:

    ### Creates secret files for github. The target service must be the first argument
    $script_file_name github jessenich ghp_d52beab3-ead6-4a8f-98af-a5ef87e9d218

    ### The following will error. Interactively must be specified explicitly.
    $script_file_name --dockerhub

    ### Creates the necessary dockerhub secret files interactively
    $script_file_name --dockerhub --read-username-std-in --read-token-std-in

    ### Create Azure Resource Secret
    $script_file_name --azure myazurestorageresource secret_value_1 secret_value_2

    ### Create Azure Storage SAS & Connection String
    # Opt1: SAS
    $script_file_name \
        AzureCloud \
        'sv=2020-08-04&ss=b&srt=... \
        'https://myazurestorageresource...' \
        --primary-name "sas-token"
        --secondary-name "
EOF
}

parse_args() {
    local argpos=0;
    local scoped_positional=true;
    local exit_positional=4;
    case "$1" in
        *[Hh]elp)
            show_usage;
            exit 1;;

        -g | -gh | --github | \
        [Gg][Hh] | [Gg]it[Hh]ub)
            secret_type="git-remote"
            secret_service="github";;

        -dv | --devops | --azure-devops | \
        [Dd]ev[Oo]ps | [Aa]zure-[Dd]ev[Oo]ps | "[Aa]zure [Dd]ev[Oo]ps")
            secret_type="git-remote"
            secret_service="azdevops";;

        -gl | --gitlab | \
        [Gg]it[Ll]ab)
            secret_type="git-remote";
            secret_service="gitlab";;

        -jb | --jetbrains-spaces | \
        [Ss]paces | [Jj]et[Bb]rains | [Jj]et[Bb]rains-[Ss]paces)
            secret_type="git-remote";
            secret_service="jetbrains";;

        -b | --bb | --bitbucket | \
        [Bb]it[Bb]ucket)
            secret_type="git-remote";
            secret_service="bitbucket";;

        -d | -dh | --dockerhub | \
        [Dd]ocker | [Dd]ocker[Hh]ub | [Dd]ocker.[Ii][Oo])
            secret_type="docker-registry"
            secret_service="dockerhub";;

        -acr | --azure-container-registry | \
        [Aa][Cc][Rr] | "[Aa]zure [Cc]ontainer [Rr]egistry" | [Aa]zure-[Cc]ontainer-[Rr]egistry)
            secret_type="docker-registry";
            secret_service="azure-container-registry";;

        -az | --azure | --azure-cloud | \
        [Aa][Zz] | [Aa]zure | "[Aa]zure [Cc]loud" | [Aa]zure-[Cc]loud | [Aa]zure[Cc]loud)
            secret_type="cloud";
            secret_service="azure-cloud";;

        -gcp | --google-cloud | --google-cloud-platform | \
        [Gg][Cc][Pp] | "[Gg]oogle [Cc]loud" | [Gg]oogle-[Cc]loud)
            secret_type="cloud";
            secret_service="google-cloud";;

        -aws | --amazon | --amazon-web-services | \
        [Aa][Ww][Ss] | [Aa]mazon-[Ww]eb-[Ss]ervices | "[Aa]mazon [Ww]eb [Ss]ervices")
            secret_type="cloud";
            secret_service="aws-cloud";;

        -do | --digital-ocean | \
        [Dd][Oo] | [Dd]igital-[Oo]cean | "[Dd]igital [Oo]cean")
            secret_type="cloud";
            secret_service="digital-ocean-cloud";;

        -j | --jira | \
        [Jj]ira)
            secret_type="tasking";
            secret_service="jira_boards";;

        --asana | \
        [Aa]sana)
            secret_type="tasking";
            secret_service="asana";;

    esac
    shift;
    argpos+=1;

    while [ "$#" -gt 0 ]; do
        case "$1" in
            -rP | --read-primary-std-in)
                read_primary=true;
                argpos+=1
                shift;;

            -rS | --read-secondary-std-in)
                read_secondary=true;
                argpos+=1
                shift;;

            -rT | --read-tertiary-std-in)
                read_tertiary=true;
                argpos+=1
                shift;;

            -rQ | --read-quaternary-std-in)
                read_quaternary=true;
                argpos+=1
                shift;;

            # Name arguments optional during addition, requireed for successful update
            -Pn | --primary-name)
                if [ -z "$2" ]; then show_usage && exit 1; fi
                primary_name="$2";
                argpos+=2
                shift 2;;

            -Sn | --secondary-name)
                if [ -z "$2" ]; then show_usage && exit 1; fi
                secondary_name="$2";
                argpos+=2
                shift 2;;

            -Tn | --tertiary-name)
                if [ -z "$2" ]; then show_usage && exit 1; fi
                tertiary_name="$2";
                argpos+=2
                shift 2;;

            -Qn | --quaternary-name)
                if [ -z "$2" ]; then show_usage && exit 1; fi
                quaternary_name="$2";
                argpos+=2
                shift 2;;

            # Ignore arguments only apply during updates.
            -iP | --ignore-first)
                exclude1=true;
                argpos+=1
                shift;;

            -iS | --ignore-secondary)
                exclude2=true;
                argpos+=1
                shift;;

            -iT | --ignore-tertiary)
                exclude3=true;
                argpos+=1;
                shift;;

            -iQ | --ignore-quaternary)
                exclude4=true;
                argpos+=1;
                shift;;

            --source-only)
                do_run=false;
                argpos+=1
                shift;;

            --correlation-id)
                if [ -z "$2" ]; then echo_usage && exit 1; fi
                correlation_id="$2";
                shift 2;;

            --log-level)
                case "$2" in
                    [Vv]*) log_level=5;;
                    [Dd]*) log_level=4;;
                    [Ii]*) log_level=3;;
                    [Ww]*) log_level=2;;
                    [Ee]*) log_level=1;;
                    [Ff]*) log_level=0;;
                esac
                shift 2;;

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

_chuser_parse_args() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            -g | --group)
               grps+=( "$2" );
               shft;;

            -u | --user)
                local user="$2";
                shift 2;;
    done

}

while true; do
    read -p "Do you wish to install SQL Server Tools for Linux? [Y/n] " yn
    case $yn in
        [Nn]* ) do_continue=false && break;;
        *) do_continue=true && break;;
    esac
done

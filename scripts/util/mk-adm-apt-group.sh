#!/usr/bin/env bash

user="${1:-}";
shift;
group="${1:-adm}"
shift;

__chown_apt_lists() {
    sudo chown "$1" /var/lib/dpkg/lock-frontend;
    sudo chown "$1" /var/lib/dpkg/lock;
    sudo chown --recursive "$1" /var/lib/apt/lists;
    sudo chown --recursive "$1" /var/cache/apt;
}

__chmod_apt_lists() {
    chmod "$1" /var/lib/dpkg/lock-frontend;
    chmod "$1" /var/lib/dpkg/lock;
    chmod --recursive "$1" /var/cache/apt/;
    chmod --recursive "$1" /var/lib/apt;
}

__edit_sudoers_visudo_noninteractive() {
    if [ -z "$1" ]; then exit 3; fi
    local EDITOR_CACHE="$EDITOR";
    export EDITOR='tee -a';
    echo "EDITING /etc/sudoers ! DO NOT INTERRUPT BEFORE THIS IS FINISHED!";

    echo "# Allow $1 to access apt without the use of the sudo command" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt update" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt upgrade" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt install" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt reinstall" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt remove" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt autoremove" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt full-upgrade" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt satisfy" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get update" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get upgrade" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get install" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get remove" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get purge" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get autoclean" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get dist-upgrade" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get dselect-upgrade" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get source" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get download" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get changelog" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /usr/bin/apt-get check" | sudo -E visudo
    echo "$1 ALL=NOPASSWD: /var/lib/dpkg/lock-frontend" | sudo -E visudo

    EDITOR="$EDITOR_CACHE";
    unset EDITOR_CACHE;
}

if [ -z "$user" ] && [ -z "$group" ]; then
  echo "User or group name is required." >&2;
  exit 2;
elif [ -n "$user" ]; then
    if [ -n "$group" ]; then
        __edit_sudoers_visudo_noninteractive "$user";
        __edit_sudoers_visudo_noninteractive "%$group";
        __chown_apt_lists "$user:$group";
        __chmod_apt_lists "ug+w";
    else
        __edit_sudoers_visudo_noninteractive "$user";
        __chown_apt_lists "$user";
        __chmod_apt_lists "u+w";
    fi
else
    __edit_sudoers_visudo_noninteractive "%$group";
    __chown_apt_lists ":$group";
    __chmod_apt_lists "g+w";
fi

echo "Running 'apt update' without sudo to test all is working...";
apt update;

exit $?;

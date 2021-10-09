#!/usr/bin/env bash

user="${1:-}";
shift;
group="${1:-adm}"
shift;

__chown_apt_lists() {
    sudo chown "$__chowners" /var/lib/dpkg/lock-frontend;
    sudo chown "$__chowners" /var/lib/dpkg/lock;
    sudo chown --recursive "$__chowners" /var/lib/apt/lists;
    sudo chown --recursive "$__chowners" /var/cache/apt;
}

__chmod_apt_lists() {
  chmod "$__chmods" /var/lib/dpkg/lock-frontend;
  chmod "$__chmods" /var/lib/dpkg/lock;
  chmod --recursive "$__chmods" /var/cache/apt/;
  chmod --recursive "$__chmods" /var/lib/apt;
}

__edit_sudoers_visudo_noninteractive() {
    local sudoer="$1";
    if [ -z "$sudoer" ]; then
        exit 3;
    fi

    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt update" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt upgrade" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt install" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt reinstall" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt remove" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt autoremove" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt full-upgrade" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt satisfy" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get update" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get upgrade" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get install" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get remove" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get purge" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get autoclean" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get dist-upgrade" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get dselect-upgrade" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get source" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get download" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get changelog" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /usr/bin/apt-get check" | sudo EDITOR='tee -a' visudo
    echo "$sudoer ALL=NOPASSWD: /var/lib/dpkg/lock-frontend" | sudo EDITOR='tee -a' visudo
}

if [ -z "$user" ] && [ -z "$group" ]; then
  echo "User or group name is required." >&2;
  exit 2;
elif [ -n "$user" ]; then
    if [ -n "$group" ]; then
        __chowners="$user:$group";
        __chmods="ug+w";
    else
        __chowners="$user";
        __chmods="u+w";
    fi
else
    __chowners=":$group";
    __chmods="u+w";
fi





echo "Running 'apt update' without sudo to test all is working...";
apt update;

exit $?;

#!/usr/bin/env bash

# https://docs.docker.com/engine/install/ubuntu/

__install_docker() {
    local __apt_update="0";
    local __apt_upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --update)
                __apt_update="1";
                shift;;

            --upgrade)
                __apt_upgrade="1";
                shift;;
        esac
    done

    if [ "$__apt_update" -eq "1" ]; then sudo apt-get update; fi
    if [ "$__apt_upgrade" -eq "1" ]; then sudo apt-get upgrade; fi

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update;
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    # apt-cache madison docker-ce
    # sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R

    if ! which docker > /dev/null; then
        echo "Unknown error occurred. Docker installation not detected. which docker: $(which docker)" >&2;
        exit 1;
    fi

    if ! sudo systemctl status docker | grep -qoE 'Active: active \(running\).*';  then
        sudo systemctl enable docker.service;
        sudo systemctl enable containerd.service;
        sudo systemctl start docker.service;
        sudo systemctl start containerd.service;
    fi

    __daemon_file="$(cat <<'EOF'
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]
}
EOF
)"
    echo "$__daemon_file" | sudo tee /etc/docker/daemon.json

}

__make_docker_group() {
    sudo groupadd docker
    sudo usermod -aG docker "$USER"
}

__install_docker "$@";
__make_docker_group;

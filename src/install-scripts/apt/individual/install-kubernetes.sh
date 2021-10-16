#!/usr/bin/env bash

__install_docker() {
    local __apt_upgrade="0";

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --upgrade)
                __apt_upgrade="1";
                shift;;
        esac
    done

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
    sudo apt-add-repository "deb http://apt.kubernetes.io/kubernetes-xenial main"

    sudo apt-get update;
    sudo apt-get upgrade;

    sudo apt-get install kubeadm kubelet kubectl;
    sudo apt-mark hold kubeadm kubelet kubectl;

    if ! which kubeadm > /dev/null; then
        echo "Unknown error occurred. Docker installation not detected. which docker: $(which docker)" >&2;
        exit 1;
    fi

    if ! sudo systemctl status docker | grep -qoE 'Active: active \(running\).*';  then
        sudo systemctl enable docker;
        sudo systemctl start docker;
    fi

    sudo swapoff –a;

    sudo hostnamectl set-hostname master-node
    sudo hostnamectl set-hostname w1
}

__install_docker "$@";

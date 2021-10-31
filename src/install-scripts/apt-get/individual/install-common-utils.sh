#!/usr/bin/env bash

sudo apt-get update;

## APT Utils:
sudo apt-get install -y \
    apt-transport-https;
    ubuntu-restricted-extras

## Gnome Extensions
sudo apt-get install -y \
    chrome-gnome-shell \
    network-manager-ssh-gnome;

## General utilities
sudo apt-get install -y \
    curl \
    debian-goodies \
    dkms \
    rsync \
    rsync-ssl \
    unzip \
    wget \
    wzip \
    zip;

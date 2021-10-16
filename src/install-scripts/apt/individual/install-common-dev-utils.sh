#!/usr/bin/env bash

sudo apt-get update;

## Build Tools
sudo apt-get install -y \
    build-essential \
    make \
    cmake \
    cake

## Linting Tools
sudo apt-get install -y \
    shellcheck

## Git Utilities
# Better Git Doc
sudo apt-get install -y \
    git \
    gitg \
    gitmagic \
    gitweb;

## Git Auxillaries
sudo apt-get install -y \
    git-all \
    git-annex \
    git-annex-remote-rclone \
    git-doc \
    git-extras \
    git-filter-repo \
    git-ftp \
    git-lfs \
    git-man \
    git-quick-stats;

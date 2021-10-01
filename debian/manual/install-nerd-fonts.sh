#!/usr/bin/env bash

# shellcheck disable=SC2015

mkdir -p "$HOME/.local/share/fonts" && \
cd "$HOME/.local/share/fonts" || \
(echo "$HOME/.local/share/fonts dot net exist and could not be created." && exit 1);
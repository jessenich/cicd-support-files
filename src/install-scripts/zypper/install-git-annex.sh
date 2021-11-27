#!/usr/bin/env bash

zypper addrepo https://download.opensuse.org/repositories/devel:languages:haskell/openSUSE_Leap_15.2/devel:languages:haskell.repo
zypper refresh
zypper install git-annex

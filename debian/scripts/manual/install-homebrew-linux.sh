#!/usr/bin/env bash

# Install dependencies
sudo apt-get install build-essential

# Download and run install script
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Success Read Out:
# ==> Homebrew has enabled anonymous aggregate formulae and cask analytics.
# Read the analytics documentation (and how to opt-out) here:
#   https://docs.brew.sh/Analytics
# No analytics data has been sent yet (or will be during this `install` run).

# ==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
#   https://github.com/Homebrew/brew#donations

# ==> Next steps:
# - Run these two commands in your terminal to add Homebrew to your PATH:
#     echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jesse/.profile
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# - Run `brew help` to get started
# - Further documentation: 
#     https://docs.brew.sh
# - Install the Homebrew dependencies if you have sudo access:
#     sudo apt-get install build-essential
#     See https://docs.brew.sh/linux for more information
# - We recommend that you install GCC:
#     brew install gcc

## Unlike bash, zsh does not get called via a source script within .profile. Duplicate if zshrc exists.
rc_additions=$(cat <<EOF

# Import brews shell env
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> "$HOME/.zshrc"

# Disable telemetry from homebrew
export HOMEBREW_NO_ANALYTICS=1

EOF
);

test -f "$HOME/.zshrc" && \
echo "$rc_additions" >> "$HOME/.zshrc";
echo "$rc_additions" >> "$HOME/.profile";

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew update && \
brew install gcc
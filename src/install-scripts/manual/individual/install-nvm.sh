#!/usr/bin/env bash



__install_nvm() {
    local current=true;
    local lts=true;
    local versions=( );

    while [ "$#" -gt 0 ]; do
        case "$1" in
            -*c | --current)
                current=true;
                shift;;
            -*l | --lts)
                lts=true;
                shift;;

            -*v | --version | --versions)
                while [[ "$2" =~ ^[0-9]+([.][0-9]+)?$ ]]; do
                    versions+=( "$2" );
                done
                shift;;
        esac
    done

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

    # The script clones the nvm repository to ~/.nvm and adds the source line to
    # your profile (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).
    # (You can add the source loading line manually, if the automated install tool does not add it for you.)

    nvmloader_bash="$(cat \
<<'EOF'

if [ -d "$HOME/.nvm" ]; then
    # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    export NVM_DIR="$HOME/.nvm"

    # This loads nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # This loads nvm bash_completion
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi
EOF
)"

    nvmloader_zsh="$(cat \
<<'EOF'

if [ -d "$HOME/.nvm" ]; then
    # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    export NVM_DIR="$HOME/.nvm"

    # This loads nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi
EOF
)"

    if [ -f "$HOME/.bashrc" ]; then echo "$nvmloader_bash" >> "$HOME/.bashrc"; fi
    if [ -f "$HOME/.zshrc" ]; then echo "$nvmloader_zsh" >> "$HOME/.zshrc"; fi
}

__install_nvm "$@";

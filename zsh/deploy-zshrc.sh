#!/bin/bash
set -x

if [[ ! -d "/usr/share/oh-my-zsh/" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

ln -sf "${SCRIPT_PATH}"/zshrc ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv

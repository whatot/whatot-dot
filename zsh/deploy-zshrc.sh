#!/bin/bash
set -x

if [[ ! -d "/usr/share/oh-my-zsh/" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

SCRIPT_PATH=$(dirname "$(realpath "$0")")

ln -sf "${SCRIPT_PATH}"/zshrc ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv

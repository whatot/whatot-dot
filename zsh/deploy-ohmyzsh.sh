#!/usr/bin/env bash
set -aux

if [[ ! -d "/usr/share/oh-my-zsh/" ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

SCRIPT_PATH=$(
    cd "$(dirname "$0")" || return
    pwd -P
)

ln -sf "${SCRIPT_PATH}"/ohmyzsh.zsh ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv

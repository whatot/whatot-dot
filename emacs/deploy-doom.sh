#!/bin/bash
set -x

PATH_NOW=$(pwd)
EMACS_D_PATH="${HOME}/.emacs.d"
DOOM_D_PATH="${HOME}/.doom.d"
PRIVATE_CONFIG_PATH="${HOME}/.emacs.d/modules/config/private"
PRIVATE_CONFIG_FILE="${PRIVATE_CONFIG_PATH}/config.el"

if [[ ! -d "${DOOM_D_PATH}" ]]; then
    mkdir -p "${DOOM_D_PATH}"
    ln -s "${PATH_NOW}"/doom.el "${DOOM_D_PATH}"/init.el
fi

if [[ ! -d "${EMACS_D_PATH}" ]]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
fi

if [[ ! -d "${PRIVATE_CONFIG_PATH}" ]]; then
    mkdir -p "${PRIVATE_CONFIG_PATH}"
    ln -s "${PATH_NOW}"/doom-private-config.el "${PRIVATE_CONFIG_FILE}"
fi

cd "${EMACS_D_PATH}" || return
git checkout develop
make install

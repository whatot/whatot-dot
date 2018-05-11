#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
EMACS_D_PATH="${HOME}/.emacs.d"
DOOM_D_PATH="${HOME}/.doom.d"
PRIVATE_SOURCE_PATH="${SCRIPT_PATH}/private"
PRIVATE_TARGET_PATH="${HOME}/.emacs.d/modules/config/private"

mkdir -p "${DOOM_D_PATH}"
ln -sf "${SCRIPT_PATH}"/doom-init.el "${DOOM_D_PATH}"/init.el

if [[ ! -d "${EMACS_D_PATH}" ]]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
fi

if [[ ! -d "${PRIVATE_TARGET_PATH}" ]]; then
    ln -sf "${PRIVATE_SOURCE_PATH}" "${PRIVATE_TARGET_PATH}"
fi

cd "${EMACS_D_PATH}" || return
git checkout develop
make upgrade

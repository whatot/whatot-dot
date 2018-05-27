#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
EMACS_D_PATH="${HOME}/.emacs.d"
DOOM_D_PATH="${HOME}/.doom.d"

if [[ ! -d "${DOOM_D_PATH}" ]]; then
    ln -sf "${SCRIPT_PATH}" "${DOOM_D_PATH}"
fi

if [[ ! -d "${EMACS_D_PATH}" ]]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
fi

cd "${EMACS_D_PATH}" || return
git checkout develop
git pull
make install
# make update

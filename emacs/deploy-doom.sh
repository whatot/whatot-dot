#!/bin/bash
set -x

PATH_NOW=$(pwd)
EMACS_D_PATH="${HOME}/.emacs.d"
DOOM_D_PATH="${HOME}/.doom.d"

if [[ ! -d "${DOOM_D_PATH}" ]]; then
    mkdir -p ${DOOM_D_PATH}
    ln -s ${PATH_NOW}/doom.el ${DOOM_D_PATH}/init.el
fi

if [[ ! -d "${EMACS_D_PATH}" ]];then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
fi

cd "${EMACS_D_PATH}" || return
git checkout develop
make install

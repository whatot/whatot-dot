#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s "${SCRIPT_PATH}"/spacemacs.el ~/.spacemacs

EMACS_D_PATH="${HOME}/.emacs.d"
if [[ ! -d "${EMACS_D_PATH}" ]];then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd "${EMACS_D_PATH}" || return
git checkout develop

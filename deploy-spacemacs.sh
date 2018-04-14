#!/bin/bash
set -x

PATH_NOW=$(pwd)

if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s "${PATH_NOW}"/spacemacs.el ~/.spacemacs

sudo bash -c 'cat > /usr/bin/emacs.wrapper' <<EOF
#! /bin/bash
export LC_CTYPE=zh_CN.UTF-8; emacsclient -c -a emacs
EOF

sudo chmod +x /usr/bin/emacs.wrapper

EMACS_D_PATH="${HOME}/.emacs.d"
if [[ ! -d "${EMACS_D_PATH}" ]];then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd "${EMACS_D_PATH}" || return
git checkout develop

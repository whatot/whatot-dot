#!/bin/bash
set -x

EMACS_WRAPPER_PATH="/usr/bin/emacs.wrapper"

if [[ ! -f "${EMACS_WRAPPER_PATH}" ]]; then

    sudo bash -c 'cat > ${EMACS_WRAPPER_PATH}' <<EOF
#! /bin/bash
export LC_CTYPE=zh_CN.UTF-8; emacsclient -c -a emacs
EOF

    sudo chmod +x "${EMACS_WRAPPER_PATH}"
fi


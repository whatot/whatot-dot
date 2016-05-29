#!/bin/bash
set -x

PATH_NOW=`pwd`

if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s ${PATH_NOW}/spacemacs.el ~/.spacemacs

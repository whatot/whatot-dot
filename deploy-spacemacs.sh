#!/bin/bash
set -x

PATH_NOW=`pwd`

if [[ -f "/usr/bin/pacman" ]];then
    sudo pacman -S ipython python-nose
fi

if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s ${PATH_NOW}/spacemacs.el ~/.spacemacs

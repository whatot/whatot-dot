#!/bin/bash
set -x

PATH_NOW=`pwd`

if [[ -f "/usr/bin/pacman" ]];then
    sudo pacman -S ipython python-nose
    cargo install rustfmt racer
fi

## for go
# go get -u -v github.com/nsf/gocode
# go get -u -v github.com/rogpeppe/godef
# go get -u -v golang.org/x/tools/cmd/oracle
# go get -u -v golang.org/x/tools/cmd/gorename
# go get -u -v golang.org/x/tools/cmd/goimports


if [[ -f "${HOME}/.spacemacs" ]]; then
    mv ~/.spacemacs ~/.spacemacs.bak
fi

ln -s ${PATH_NOW}/spacemacs.el ~/.spacemacs

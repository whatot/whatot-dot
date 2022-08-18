#!/bin/bash
set -x

SCRIPT_PATH=$(dirname $(realpath "$0"))

if [[ -f "${HOME}/.vimrc" ]]; then
	mv ~/.vimrc ~/.vimrc.backup
fi

# all needed subdirs
mkdir -p ~/.vim/{plugged,sessions,undodir,autoload}

ln -sf "${SCRIPT_PATH}"/tiny.vim ~/.vimrc


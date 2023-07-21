#!/bin/bash
set -x

SCRIPT_PATH=$(
	cd "$(dirname "$0")" || return
	pwd -P
)

if [[ -f "${HOME}/.vimrc" ]]; then
	mv ~/.vimrc ~/.vimrc.backup
fi

# all needed subdirs
mkdir -p ~/.vim/{plugged,sessions,undodir,autoload}

ln -sf "${SCRIPT_PATH}"/minimal.vim ~/.vimrc

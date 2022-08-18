#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(greadlink -f "$0")")

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -f "${HOME}/.vimrc" ]]; then
	mv ~/.vimrc ~/.vimrc.backup
fi

# all needed subdirs
mkdir -p ~/.vim/{plugged,sessions,undodir,autoload}
ln -sf "${SCRIPT_PATH}"/new.vim ~/.vimrc

# Using vim-plug to install plugins in github
vim +PlugInstall +qall

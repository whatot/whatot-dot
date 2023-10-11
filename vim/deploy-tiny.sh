#!/bin/bash
set -x

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -f "${HOME}/.vimrc" ]]; then
  mv ~/.vimrc ~/.vimrc.backup
fi

# all needed subdirs
mkdir -p ~/.vim/{plugged,sessions,undodir,autoload}
ln -sf "${SCRIPT_PATH}"/tiny.vim ~/.vimrc

# Using vim-plug to install plugins in github
vim +PlugInstall +qall

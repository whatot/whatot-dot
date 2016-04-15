#!/bin/bash
set -x

PATH_NOW=`pwd`

bash ./install-deps.sh

if [[ -f "${HOME}/.vimrc" ]]; then
	mv ~/.vimrc ~/.vimrc.backup
fi

# all needed subdirs
mkdir -p ~/.vim/{bundle,sessions,undodir,autoload}
ln -s ${PATH_NOW}/ycm.vim ~/.vimrc

if [[ ! -d "${HOME}/.vim/bundle/neobundle.vim" ]]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# Using NeoBundle to install plugins in github
vim +NeoBundleInstall +qall


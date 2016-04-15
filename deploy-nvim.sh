#!/bin/bash
set -x

PATH_NOW=`pwd`

bash ./install-deps.sh

if [[ -f "${HOME}/.config/nvim/init.vim" ]]; then
	mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

# all needed subdirs
mkdir -p ~/.config/nvim/{bundle,sessions,undodir,autoload}
ln -s ${PATH_NOW}/nvim.vim ~/.config/nvim/init.vim

if [[ ! -d "${HOME}/.config/nvim/bundle/neobundle.vim" ]]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim
fi

# Using NeoBundle to install plugins in github
nvim +NeoBundleInstall +qall


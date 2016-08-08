#!/bin/bash
set -x

PATH_NOW=`pwd`

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -f "${HOME}/.config/nvim/init.vim" ]]; then
	mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

if [[ -f "${HOME}/.config/nvim/ginit.vim" ]]; then
	mv ~/.config/nvim/ginit.vim ~/.config/nvim/ginit.vim.backup
fi

# all needed subdirs
mkdir -p ~/.config/nvim/{plugged,sessions,undodir,autoload}
ln -s ${PATH_NOW}/nvim.vim ~/.config/nvim/init.vim
ln -s ${PATH_NOW}/ginit.vim ~/.config/nvim/ginit.vim

# Using vim-plug to install plugins in github
nvim +PlugInstall +qall

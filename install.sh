#!/bin/bash
#
# 此vimrc需要ctags,cscope,ycm等,并暂时只支持linux,其余系统未测试
# git clone https://github.com/whatot/whatot-vimrc.git

if [ -f "~/.vimrc"  ]; then
  cp ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

git submodule update --init --recursive

# 也可以使用 ln -s <source> <destination>
cp whatot-vimrc/.vimrc ~/.vimrc
vim +BundleInstall +qa

cp whatot-vimrc/filenametags ~/.vim/
ctags -R -f ~/.vim/systags /usr/include /usr/local/include

#!/bin/bash
#
#此vimrc需要ctags,cscope等,并暂时只支持linux,其余系统未测试

if [ -f "~/.vimrc"  ]; then
  cp ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/whatot/whatot-vimrc.git

cp whatot-vimrc/.vimrc ~/.vimrc
vim +BundleInstall +qa

#这个mru.vim是lilydjwg的修改版本,但还是有些许问题
#注销mru.vim之后下句可以去掉了
#cp whatot-vimrc/mru.vim ~/.vim/bundle/mru.vim/plugin/mru.vim
cp whatot-vimrc/filenametags ~/.vim/
ctags -R -f ~/.vim/systags /usr/include /usr/local/include

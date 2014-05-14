#!/usr/bin/env bash
#
# before running this script,
# 'git clone https://github.com/whatot/whatot-dot.git' is needed,
# because this file need the vimrc in the directory.
#
set -x

PATH_NOW=`pwd`

echo
echo "######## first: install tools needed (include global) ##################"
echo

# In archlinux
if [ -f "/usr/bin/pacman" ];then
	sudo pacman -S git gvim ack cscope flake8 python2-flake8 \
		the_silver_searcher
	# for global in AUR
	if [ -f "/usr/bin/yaourt" ];then
		yaourt -S global
	else
		echo "global need yaourt to install !!"
	fi

# In debian, Ubuntu
elif [ -f "/usr/bin/apt-get" ];then
	sudo apt-get install git vim-gtk ack cscope silversearcher-ag
	# global is too old to use, so build from source.
	if [ ! -f "/tmp/global_build/global-6.2.12.tar.gz" ];then
		mkdir -p /tmp/global_build/
		cd /tmp/global_build/
		wget ftp://ftp.gnu.org/pub/gnu/global/global-6.2.12.tar.gz
	fi
	tar xvf global-6.2.12.tar.gz
	cd global-6.2.12 && ./configure && sudo make install
	cd .. && sudo rm -rf /tmp/global_build/global-6.2.12/
else
	echo "the distrbution not supported now"
fi

echo
echo "######## second: copy vimrc and plugins  ##################"
echo

if [ -f ~/".vimrc"  ]; then
	mv ~/.vimrc ~/.vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cd $PATH_NOW
ln -s $(pwd)/.vimrc ~/.vimrc

# Using bundle to install plugins in github
vim +BundleInstall +BundleClean! +qa

echo
echo "######## third: build vimproc, ycm ##################"
echo

make -C ~/.vim/bundle/vimproc

cd ~/.vim/bundle/YouCompleteMe/ \
	&& ./install.sh --clang-completer --system-libclang

cd $PATH_NOW

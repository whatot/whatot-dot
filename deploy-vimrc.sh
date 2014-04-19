#!/usr/bin/env bash
#
# before running this script,
# 'git clone https://github.com/whatot/whatot-dot.git' is needed,
# because this file need the vimrc in the directory.
#
# set -x

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
	if [ -d "/tmp/global_build/global-6.2.12" ];then
		rm -rf /tmp/global_build/global-6.2.12
	fi
	mkdir -p /tmp/global_build/
	cd /tmp/global_build/
	wget ftp://ftp.gnu.org/pub/gnu/global/global-6.2.12.tar.gz
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

# build ycm, need libclang.so
if [ -d "/tmp/ycm_build/" ];then
	rm -rf /tmp/ycm_build/
fi

if [ -f "/usr/lib/libclang.so" ];then
	# In archlinux
	mkdir /tmp/ycm_build/ \
		&& cd /tmp/ycm_build/ \
		&& cmake -G "Unix Makefiles" \
		-DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.so . \
		~/.vim/bundle/YouCompleteMe/cpp \
		&& make ycm_core
elif [ -f "/usr/lib/x86_64-linux-gnu/libclang-3.4.so.1" ];then
	# In Ubuntu 12.04 libclang-common-3.4
	mkdir /tmp/ycm_build/ \
		&& cd /tmp/ycm_build/ \
		&& cmake -G "Unix Makefiles" \
		-DEXTERNAL_LIBCLANG_PATH=/usr/lib/x86_64-linux-gnu/libclang-3.4.so.1 \
		. ~/.vim/bundle/YouCompleteMe/cpp \
		&& make ycm_core
else
	cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer
fi

if [ -d "/tmp/ycm_build/" ];then
	rm -rf /tmp/ycm_build/
fi

cd $PATH_NOW

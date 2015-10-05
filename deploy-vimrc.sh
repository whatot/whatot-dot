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
echo " Softwares maybe need:"
echo " flake8 python-flake8 cscope ctags"
echo

# In archlinux
if [[ -f "/usr/bin/pacman" ]];then
	sudo pacman -S git gvim ack the_silver_searcher clang llvm
	# for global in AUR, global is still in AUR
	if [[ -f "/usr/bin/yaourt" ]];then
		yaourt -S global
	else
		echo "global need yaourt to install !!"
	fi

# In debian, Ubuntu
elif [[ -f "/usr/bin/apt-get" ]];then
	sudo apt-get install git vim-gtk ack-grep cscope silversearcher-ag \
		libclang-dev libncurses5-dev
	# global is too old to use, so build from source.
	if [[ ! -f "/tmp/global_build/global-6.5.tar.gz" ]];then
		mkdir -p /tmp/global_build/
		cd /tmp/global_build/
		wget ftp://ftp.gnu.org/pub/gnu/global/global-6.5.tar.gz
	fi
	cd /tmp/global_build/
	tar xvf global-6.5.tar.gz
	cd global-6.5 && ./configure && sudo make install
	cd .. && sudo rm -rf /tmp/global_build/global-6.5/

# In fedora, not in centos
elif [[ -f "/usr/bin/yum" ]];then
	sudo yum install -y the_silver_searcher global global-ctags gvim git \
		ncurses-devel ncurses clang-devel clang llvm ack

# In funtoo or gentoo
elif [[ -f "/usr/bin/emerge" ]]; then
	sudo emerge global gvim git clang llvm ack the_silver_searcher

fi

echo
echo "######## second: copy vimrc and install plugins  ##################"
echo

if [[ -f ~/".vimrc" ]]; then
	mv ~/.vimrc ~/.vimrc-bakup
fi

# all subdirs
mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
mkdir -p ~/.vim/undodir/
mkdir -p ~/.vim/autoload/
mkdir -p ~/.vim/UltiSnips/

git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

cd $PATH_NOW
ln -s $(pwd)/.vimrc ~/.vimrc

# snippets in UltiSnips dirs
cp $(pwd)/vim/UltiSnips/*.snippets  ~/.vim/UltiSnips/

# Using NeoBundle to install plugins in github
vim +NeoBundleInstall +qall


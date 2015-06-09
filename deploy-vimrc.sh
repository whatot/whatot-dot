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
		the_silver_searcher clang llvm
	# for global in AUR
	if [ -f "/usr/bin/yaourt" ];then
		yaourt -S global
	else
		echo "global need yaourt to install !!"
	fi

# In debian, Ubuntu
elif [ -f "/usr/bin/apt-get" ];then
	sudo apt-get install git vim-gtk ack-grep cscope silversearcher-ag \
		libclang-dev libncurses5-dev
	# global is too old to use, so build from source.
	if [ ! -f "/tmp/global_build/global-6.2.12.tar.gz" ];then
		mkdir -p /tmp/global_build/
		cd /tmp/global_build/
		wget ftp://ftp.gnu.org/pub/gnu/global/global-6.2.12.tar.gz
	fi
	cd /tmp/global_build/
	tar xvf global-6.2.12.tar.gz
	cd global-6.2.12 && ./configure && sudo make install
	cd .. && sudo rm -rf /tmp/global_build/global-6.2.12/

# In fedora, not in centos
elif [ -f "/usr/bin/yum" ];then
	sudo yum install -y the_silver_searcher global global-ctags ctags \
		gvim git cscope ncurses-devel ncurses clang-devel clang llvm ack
fi

echo
echo "######## second: copy vimrc and install plugins  ##################"
echo

if [ -f ~/".vimrc"  ]; then
	mv ~/.vimrc ~/.vimrc-bakup
fi

mkdir -p ~/.vim/sessions/
mkdir -p ~/.vim/undodir/
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd $PATH_NOW
ln -s $(pwd)/.vimrc ~/.vimrc

# Using vim-plug to install plugins in github
vim +PlugInstall +PlugClean! +qa

echo
echo "######## third: build vimproc, ycm ##################"
echo

# make -C ~/.vim/plugged/vimproc

# cd ~/.vim/plugged/YouCompleteMe/ \
# 	&& ./install.sh --clang-completer --system-libclang

cd $PATH_NOW

# others

# nodejs ruby .gemrc
# sudo npm -g install instant-markdown-d
# gem install pygments.rb
# gem install redcarpet

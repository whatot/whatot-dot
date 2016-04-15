#!/usr/bin/env bash
set -x

# In archlinux
if [[ -f "/usr/bin/pacman" ]];then
	sudo pacman -S git gvim ack the_silver_searcher clang llvm boost cmake ctags cscope
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


# whatot-dot

my vunble vimrc and other config files

## vimrc linux deploy

details in ./deploy.sh

maybe useful tips
```bash
ctags -R -f ~/.vim/systags /usr/include /usr/local/include
```

* GNU global  [ftp://ftp.gnu.org/pub/gnu/global/](ftp://ftp.gnu.org/pub/gnu/global/)

> if use archlinux, deps :

```
sudo pacman -S git gvim ack cscope flake8 python2-flake8 the_silver_searcher
yaourt -S global
```

> if using debian, deps include and more :

```
sudo apt-get install git vim ack cscope silversearcher-ag global flake8
```

## tmux

* tmux/tmux.conf
* tmux/tmux.sh

## build ycm again using local libclang.so

```
	mkdir /tmp/ycm_build/ \
		&& cd /tmp/ycm_build/ \
		&& cmake -G "Unix Makefiles" \
			-DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.so . \
			~/.vim/bundle/YouCompleteMe/cpp \
		&& make ycm_core
```

## others

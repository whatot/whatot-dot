# whatot-dot

my vunble vimrc and other config files

## 1. vimrc linux deploy

__details in ./deploy.sh__

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

## 2. tmux

* tmux/tmux.conf
* tmux/tmux.sh

## 3. build ycm again using local libclang.so

```
cd ~/.vim/bundle/YouCompleteMe/ \
    && ./install.sh --clang-completer --system-libclang
```

## 4. others

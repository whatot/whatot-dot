# whatot-dot

my vunble vimrc and other config files

## vimrc linux deploy

```bash
if [ -f "~/.vimrc"  ]; then
  mv ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
mkdir -p ~/git/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/whatot/whatot-dot.git ~/git/whatot-dot

ln -s ~/git/whatot-dot/.vimrc ~/.vimrc
vim +BundleInstall +qa

cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer

make -C ~/.vim/bundle/vimproc
```

temp useless
```bash
ctags -R -f ~/.vim/systags /usr/include /usr/local/include
```


* GNU global  [ftp://ftp.gnu.org/pub/gnu/global/](ftp://ftp.gnu.org/pub/gnu/global/)

> if use archlinux, deps :

```
sudo pacman -S git gvim ack cscope
yaourt -S global flake8 python2-flake8
```

## tmux

* tmux/tmux.conf
* tmux/tmux.sh

## others


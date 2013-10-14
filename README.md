#whatot-dot

my vunble vimrc and other config files


```bash
if [ -f "~/.vimrc"  ]; then
  cp ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
mkdir -p ~/git/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/whatot/whatot-dot.git ~/git/whatot-dot

ln -s ~/git/whatot-dot/.vimrc ~/.vimrc
vim +BundleInstall +qa

ctags -R -f ~/.vim/systags /usr/include /usr/local/include

cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer

make -C ~/.vim/bundle/vimproc
```

* GNU global  [ftp://ftp.gnu.org/pub/gnu/global/](ftp://ftp.gnu.org/pub/gnu/global/)

> if use archlinux, deps :

```
sudo pacman -S git gvim ack cscope
yaourt -S global flake8 python2-flake8
```

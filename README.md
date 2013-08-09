#whatot-dot

my vunble vimrc and other config files

1. for vimrc s

```bash
if [ -f "~/.vimrc"  ]; then
  cp ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/whatot/whatot-dot.git ~/whatot-dot

ln -s ~/whatot-dot/.vimrc ~/.vimrc
vim +BundleInstall +qa

ctags -R -f ~/.vim/systags /usr/include /usr/local/include
```

### GNU global

[ftp://ftp.gnu.org/pub/gnu/global/](ftp://ftp.gnu.org/pub/gnu/global/)

Read install:

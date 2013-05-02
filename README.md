#whatot-vimrc

my vunble vimrc

1. 此vimrc,暂时只支持linux,其余系统未测试
多余的注释与无效行将会去除或修改.

2. Install

```bash
if [ -f "~/.vimrc"  ]; then
  cp ~/.vimrc .vimrc-bakup
fi

mkdir -p ~/.vim/bundle/
mkdir -p ~/.vim/sessions/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/whatot/whatot-vimrc.git

#YouCompleteMe install
git clone https://github.com/Valloric/YouCompleteMe ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe/
./install.sh --clang-completer
#install jedi python completer
git submodule update --init --recursive

cp whatot-vimrc/.vimrc ~/.vimrc
vim +BundleInstall +qa


cp whatot-vimrc/filenametags ~/.vim/
ctags -R -f ~/.vim/systags /usr/include /usr/local/include
```

3. usage
注释非常详细,但还是不全,还需整理

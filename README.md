# whatot-dot

my vunble vimrc and other config files

## ansible

The `arch.yml` in `ansible/` will install all needed packages,
and configure the localhost well.

> Only support Archlinux and Manjaro

```
cd ansible/
./config-arch.sh
```

## deploy vim and spacemacs

```
./deploy-nvim.sh
./deploy-ycm-vim.sh
./deploy-spacemacs.sh
```

## tmux

* tmux/tmux.conf
* tmux/tmux.sh

## build ycm using system-libclang and system-boost

> local libclang always older than the needed version

```
cd ~/.vim/bundle/YouCompleteMe/ \
    && python2 ./install.py --clang-completer --system-libclang --system-boost
```

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

## build ycm using system-libclang and system-boost

> local libclang always older than the needed version

```
cd ~/.vim/bundle/YouCompleteMe/ \
    && python2 ./install.py --clang-completer --system-libclang --system-boost
```

## use virtualenvwrapper

in .zshrc
```
PY_ENV_WRAPPER=/usr/bin/virtualenvwrapper.sh
if [[ -f $PY_ENV_WRAPPER ]]; then
   source $PY_ENV_WRAPPER
fi
```

in .zshenv
```
export WORKON_HOME="$HOME/envs/"
```

in .spacemacs and packages for completion
```
(setenv "WORKON_HOME" "~/envs/")

pip install anaconda-mode jedi
```

usage
```
mkdir -p $WORKON_HOME
mkvirtualenv venv35
mkvirtualenv -p /usr/bin/python2.7 venv27
workon venv35
workon venv27
```


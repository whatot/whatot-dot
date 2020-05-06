#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
DOOM_SOURCE_PATH="${HOME}/.emacs.d.doom"
DOOM_CONFIG_PATH="${HOME}/.doom.d"
EMACS_D_PATH="${HOME}/.emacs.d"

# 将doom配置指向正确位置
if [[ ! -d "${DOOM_CONFIG_PATH}" ]]; then
    ln -sf "${SCRIPT_PATH}" "${DOOM_CONFIG_PATH}"
fi

# clone源码
if [[ ! -d "${DOOM_SOURCE_PATH}" ]]; then
    git clone https://github.com/hlissner/doom-emacs "${DOOM_SOURCE_PATH}"
fi

# 将.emacs.d指向doom源码
if [[ ! -d "${EMACS_D_PATH}" ]]; then
    ln -s "${DOOM_SOURCE_PATH}" "${EMACS_D_PATH}"
elif [[ -L "${EMACS_D_PATH}" && -d "${EMACS_D_PATH}" ]]; then
    rm "${EMACS_D_PATH}"
    ln -s "${DOOM_SOURCE_PATH}" "${EMACS_D_PATH}"
fi

# 切换分支，更新操作
cd "${EMACS_D_PATH}" || return
git checkout develop
git pull

echo "!!!! ad-hoc fix !!!!"
echo "https://github.com/hlissner/doom-emacs/issues/2802"
git -C ~/.emacs.d/.local/straight/repos/melpa pull
rm -f ~/.emacs.d/.local/straight/build-cache.el
echo "!!!! ad-hoc fix !!!!"

./bin/doom refresh
./bin/doom update
./bin/doom env

#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
SPACEMACS_SRC_PATH="${HOME}/.emacs.d.spacemacs"
EMACS_D_PATH="${HOME}/.emacs.d"

# 将配置文件指向正确位置
ln -sf "${SCRIPT_PATH}"/spacemacs.el ~/.spacemacs

# 根据环境变量生成~/.spacemacs.env
bash -c 'cat > ~/.spacemacs.env' <<EOF
PATH=${PATH}
GOPATH=${GOPATH}
WORKON_HOME=${WORKON_HOME}
RUST_SRC_PATH=${RUST_SRC_PATH}
XDG_CONFIG_HOME=${HOME}/.config/
EOF

# clone源码
if [[ ! -d "${SPACEMACS_SRC_PATH}" ]];then
    git clone https://github.com/syl20bnr/spacemacs "${SPACEMACS_SRC_PATH}"
fi

# 将.emacs.d指向spacemacs源码
if [[ ! -d "${EMACS_D_PATH}" ]]; then
    ln -s "${SPACEMACS_SRC_PATH}" "${EMACS_D_PATH}"
elif [[ -L "${EMACS_D_PATH}" && -d "${EMACS_D_PATH}" ]]; then
    rm "${EMACS_D_PATH}"
    ln -s "${SPACEMACS_SRC_PATH}" "${EMACS_D_PATH}"
fi

# 切换分支，更新操作
cd "${EMACS_D_PATH}" || return
git checkout develop
git pull

#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
ln -sf "${SCRIPT_PATH}"/spacemacs.el ~/.spacemacs

# generate ~/.spacemacs.env based on zshenv result
bash -c 'cat > ~/.spacemacs.env' <<EOF
PATH=${PATH}
GOPATH=${GOPATH}
WORKON_HOME=${WORKON_HOME}
RUST_SRC_PATH=${RUST_SRC_PATH}
XDG_CONFIG_HOME=${HOME}/.config/
EOF

EMACS_D_PATH="${HOME}/.emacs.d"
if [[ ! -d "${EMACS_D_PATH}" ]];then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

cd "${EMACS_D_PATH}" || return
git checkout develop

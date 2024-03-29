#!/bin/bash
set -xue

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

DOOM_SOURCE_PATH="${HOME}/.emacs.d.doom"
DOOM_CONFIG_PATH="${HOME}/.doom.d"
EMACS_D_PATH="${HOME}/.emacs.d"

# config proselint for org-mode or markdown
# https://github.com/amperser/proselint
PROSELINT_CONFIG_PATH="${HOME}/.config/proselint"
mkdir -p "${PROSELINT_CONFIG_PATH}"
cat <<EOF >"${PROSELINT_CONFIG_PATH}/config.json"
{
  "checks": {
    "lexical_illusions.misc": false,
    "typography.symbols": false
  }
}
EOF

# 将doom配置指向正确位置
if [[ ! -d "${DOOM_CONFIG_PATH}" ]]; then
  ln -sf "${SCRIPT_PATH}" "${DOOM_CONFIG_PATH}"
fi

# clone源码
if [[ ! -d "${DOOM_SOURCE_PATH}" ]]; then
  git clone https://github.com/doomemacs/doomemacs "${DOOM_SOURCE_PATH}"
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
git checkout master
git pull
./bin/doom upgrade
./bin/doom sync
./bin/doom env

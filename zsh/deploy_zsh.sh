#!/usr/bin/env bash
set -aux

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

prezto_path="${ZDOTDIR:-$HOME}/.zprezto"
if [[ -d "${prezto_path}" ]]; then
  echo "prezto already installed"
else
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${prezto_path}"
fi

cat <<EOF >"${HOME}/.config/starship.toml"
# https://starship.rs/config/
add_newline = true
battery.disabled = true
EOF

mkdir -p "${HOME}/.config/git"
cat <<EOF >"${HOME}/.config/git/ignore"
.DS_Store
EOF

cat <<EOF >"${HOME}/.npmrc"
registry=https://registry.npmmirror.com/
EOF

mkdir -p "${HOME}/.gradle"
cp -f "${SCRIPT_PATH}"/init.gradle.kts "${HOME}/.gradle"

ln -sf "${SCRIPT_PATH}"/zshrc.sh ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv.sh ~/.zshenv
ln -sf "${SCRIPT_PATH}"/zpreztorc.sh ~/.zpreztorc

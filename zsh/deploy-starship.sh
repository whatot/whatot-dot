#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(realpath "$0")")

	cat <<EOF >"${HOME}/.config/starship.toml"
# https://starship.rs/config/
add_newline = true
battery.disabled = true
EOF

ln -sf "${SCRIPT_PATH}"/starship.zsh ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv


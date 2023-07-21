#!/usr/bin/env bash
set -aux

SCRIPT_PATH=$(
	cd "$(dirname "$0")" || return
	pwd -P
)

cat <<EOF >"${HOME}/.config/starship.toml"
# https://starship.rs/config/
add_newline = true
battery.disabled = true
EOF

ln -sf "${SCRIPT_PATH}"/starship.zsh ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv

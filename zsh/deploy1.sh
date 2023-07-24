#!/usr/bin/env bash
set -aux

sys_ohmyzsh="/usr/share/oh-my-zsh/"
user_ohmyzsh="${HOME}/.oh-my-zsh/"
if [[ -d "${sys_ohmyzsh}" ]]; then
	echo "oh-my-zsh already installed assystem pkg"
elif [[ -d "${user_ohmyzsh}" ]]; then
	echo "oh-my-zsh already installed in user home"
else
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

SCRIPT_PATH=$(
	cd "$(dirname "$0")" || return
	pwd -P
)

ln -sf "${SCRIPT_PATH}"/zshrc_v1.sh ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv.sh ~/.zshenv

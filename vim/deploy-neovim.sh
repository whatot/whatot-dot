#!/usr/bin/env bash
set -aux

init_astro_nvim() {
	NVIM_CONFIG_PATH=${HOME}/.config/nvim
	if [[ ! -d "${NVIM_CONFIG_PATH}" ]]; then
		git clone --depth 1 https://github.com/AstroNvim/AstroNvim "${NVIM_CONFIG_PATH}"
		nvim
	else
		echo "${NVIM_CONFIG_PATH} already exist!"
	fi
}

init_neovide() {
	NEOVIDE_CONFIG_DIR=${HOME}/.config/neovide/
	mkdir -p "${NEOVIDE_CONFIG_DIR}"
	cat <<EOF >"${NEOVIDE_CONFIG_DIR}/config.toml"
vsync = true
maximized = true
idle = true
frame = "Full"
EOF
}

for_mac() {
	if brew ls --versions "neovim" >/dev/null; then
		echo "neovim already installed"
	else
		brew install neovim
	fi

	if brew ls --cask --versions "neovide" >/dev/null; then
		echo "neovide already installed"
	else
		brew install --cask neovide
	fi
}

for_arch() {
	sudo pacman -S neovim neovide
}

for_ubuntu() {
	echo "need impl"
}

case $(uname) in
Darwin)
	for_mac
	;;
Linux)
	OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
	case ${OS_ID} in
	ubuntu)
		for_ubuntu
		;;
	manjaro | archlinux)
		for_arch
		;;
	*)
		echo -n "unsupported os id: ${OS_ID}"
		;;
	esac
	;;
*)
	echo -n "unsuppprted os"
	;;
esac

init_astro_nvim
init_neovide

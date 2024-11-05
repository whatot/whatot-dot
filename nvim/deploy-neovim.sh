#!/usr/bin/env bash
set -aux

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

# https://neovide.dev/
# https://nvchad.com/
# A: if init nvchad error, try to rm -rf ~/.local/share/nvim rm -rf ~/.local/state/nvim && rm -rf ~/.config/nvim
# A: Run :MasonInstallAll command after lazy.nvim finishes downloading plugins.
# A: Run `Lazy sync` to update pkgs
# A: Run `:h nvui` to view docs

cleanup_nvim_config() {
  rm -rf ~/.local/share/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.config/nvim
}

sync_nvim_config() {
  NVIM_CONFIG_PATH=${HOME}/.config/nvim
  rm -rf "${NVIM_CONFIG_PATH}"
  ln -sf "${SCRIPT_PATH}" "${NVIM_CONFIG_PATH}"
}

init_neovide() {
  NEOVIDE_CONFIG_DIR=${HOME}/.config/neovide/
  mkdir -p "${NEOVIDE_CONFIG_DIR}"
  cat <<EOF >"${NEOVIDE_CONFIG_DIR}/config.toml"
vsync = true
maximized = true
idle = true
frame = "full"
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

init_neovide
sync_nvim_config
nvim +MasonInstallAll +qall
nvim +Lazy sync +qall

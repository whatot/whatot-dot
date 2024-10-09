#!/bin/bash
set -eux

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

function install_wezterm() {

  case $(uname) in
  Darwin)
    if which wezterm >/dev/null; then
      echo "wezterm installed"
    else
      brew install wezterm
    fi
    ;;
  Linux)
    OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    case ${OS_ID} in
    manjaro | archlinux)
      sudo pacman -S wezterm
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

}

install_wezterm

ln -sf "${SCRIPT_PATH}"/wezterm.lua "${HOME}/.wezterm.lua"

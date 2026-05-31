#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_LOG_PREFIX=bootstrap:arch
# shellcheck source=scripts/lib/common.sh
source "${ROOT_DIR}/scripts/lib/common.sh"
init_sudo_cmd

apply_pacman_mirror() {
  local mirrors=${DOTFILES_ARCH_MIRRORS:-${DOTFILES_ARCH_MIRROR:-https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch,https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch}}
  local archlinuxcn_mirrors=${DOTFILES_ARCHLINUXCN_MIRRORS:-${DOTFILES_ARCHLINUXCN_MIRROR:-https://mirrors.ustc.edu.cn/archlinuxcn/\$arch,https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch}}
  local enable_archlinuxcn=${DOTFILES_ENABLE_ARCHLINUXCN:-true}
  local mirror
  local tmp_file

  if [[ -f /etc/pacman.d/mirrorlist && ! -f /etc/pacman.d/mirrorlist.bak ]]; then
    "${sudo_cmd[@]}" cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  fi

  dotfiles_split_csv "${mirrors}" | while IFS= read -r mirror; do
    printf "Server = %s\n" "${mirror}"
  done | "${sudo_cmd[@]}" tee /etc/pacman.d/mirrorlist >/dev/null

  if [[ -f /etc/pacman.conf && ! -f /etc/pacman.conf.bak ]]; then
    "${sudo_cmd[@]}" cp /etc/pacman.conf /etc/pacman.conf.bak
  fi

  tmp_file=$(mktemp)
  awk '
    BEGIN { skip = 0 }
    /^\[archlinuxcn\]$/ { skip = 1; next }
    /^\[/ && skip == 1 { skip = 0 }
    skip == 0 { print }
  ' /etc/pacman.conf >"${tmp_file}"

  if [[ ${enable_archlinuxcn} == "true" ]]; then
    {
      cat "${tmp_file}"
      printf "\n[archlinuxcn]\n"
      dotfiles_split_csv "${archlinuxcn_mirrors}" | while IFS= read -r mirror; do
        printf "Server = %s\n" "${mirror}"
      done
    } | "${sudo_cmd[@]}" tee /etc/pacman.conf >/dev/null
  else
    "${sudo_cmd[@]}" tee /etc/pacman.conf <"${tmp_file}" >/dev/null
  fi

  rm -f "${tmp_file}"
}

dotfiles_split_csv() {
  printf '%s\n' "$1" | tr ',' '\n' | awk 'NF { print }'
}

apply_pacman_mirror

if [[ ${DOTFILES_ENABLE_ARCHLINUXCN:-true} == "true" ]]; then
  "${sudo_cmd[@]}" pacman-key --init
  "${sudo_cmd[@]}" pacman-key --populate archlinux
fi

base_packages=(git chezmoi mise zsh vim)
if [[ ${DOTFILES_ENABLE_ARCHLINUXCN:-true} == "true" ]]; then
  base_packages+=(archlinuxcn-keyring)
fi

"${sudo_cmd[@]}" pacman -Syu --needed --noconfirm "${base_packages[@]}"

if ! command -v paru >/dev/null 2>&1 && ! command -v yay >/dev/null 2>&1; then
  echo "AUR helper not found. Install paru or yay before installing AUR packages." >&2
fi

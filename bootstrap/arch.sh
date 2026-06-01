#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_LOG_PREFIX=bootstrap:arch
# shellcheck source=scripts/lib/common.sh
source "${ROOT_DIR}/scripts/lib/common.sh"
init_sudo_cmd

pacman_server_lines() {
  local mirrors=$1
  local mirror

  printf '%s\n' "${mirrors}" | tr ',' '\n' | awk 'NF { print }' | while IFS= read -r mirror; do
    printf "Server = %s\n" "${mirror}"
  done
}

configure_pacman_mirrors() {
  local default_arch_mirrors
  local default_archlinuxcn_mirrors
  local mirrors
  local archlinuxcn_mirrors
  local tmp_file

  default_arch_mirrors="https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch,https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch"
  default_archlinuxcn_mirrors="https://mirrors.ustc.edu.cn/archlinuxcn/\$arch,https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch"
  mirrors=${DOTFILES_ARCH_MIRRORS:-${DOTFILES_ARCH_MIRROR:-${default_arch_mirrors}}}
  archlinuxcn_mirrors=${DOTFILES_ARCHLINUXCN_MIRRORS:-${DOTFILES_ARCHLINUXCN_MIRROR:-${default_archlinuxcn_mirrors}}}

  backup_file /etc/pacman.d/mirrorlist
  pacman_server_lines "${mirrors}" | "${sudo_cmd[@]}" tee /etc/pacman.d/mirrorlist >/dev/null

  backup_file /etc/pacman.conf
  tmp_file=$(mktemp)
  awk '
    BEGIN { skip = 0; blanks = 0 }
    /^\[archlinuxcn\]$/ { skip = 1; next }
    /^\[/ && skip == 1 { skip = 0 }
    skip == 1 { next }
    /^[[:space:]]*$/ { blanks++; next }
    {
      while (blanks > 0) {
        print ""
        blanks--
      }
      print
    }
  ' /etc/pacman.conf >"${tmp_file}"

  {
    cat "${tmp_file}"
    printf "\n[archlinuxcn]\n"
    pacman_server_lines "${archlinuxcn_mirrors}"
  } | "${sudo_cmd[@]}" tee /etc/pacman.conf >/dev/null

  rm -f "${tmp_file}"
}

install_arch_bootstrap_packages() {
  install_packages_from_file "${ROOT_DIR}/packages/arch/init.txt" \
    "${sudo_cmd[@]}" pacman -Syu --needed --noconfirm
  "${sudo_cmd[@]}" pacman-key --init
  "${sudo_cmd[@]}" pacman-key --populate archlinux
  install_packages_from_file "${ROOT_DIR}/packages/arch/init-archlinuxcn.txt" \
    "${sudo_cmd[@]}" pacman -S --needed --noconfirm
  install_packages_from_file "${ROOT_DIR}/packages/arch/init-aur-helper.txt" \
    "${sudo_cmd[@]}" pacman -S --needed --noconfirm
}

main() {
  configure_pacman_mirrors
  install_arch_bootstrap_packages
}

main "$@"

#!/usr/bin/env bash

dotfiles_kernel_name() {
  uname -s
}

dotfiles_load_os_release() {
  if [[ -n ${DOTFILES_OS_RELEASE_LOADED:-} ]]; then
    return 0
  fi

  if [[ ! -r /etc/os-release ]]; then
    echo "unsupported linux: missing /etc/os-release" >&2
    return 1
  fi

  # shellcheck disable=SC1091
  . /etc/os-release
  DOTFILES_OS_RELEASE_LOADED=1
  DOTFILES_OS_RELEASE_ID=${ID:-}
  DOTFILES_OS_RELEASE_CODENAME=${VERSION_CODENAME:-}
  export DOTFILES_OS_RELEASE_LOADED DOTFILES_OS_RELEASE_ID DOTFILES_OS_RELEASE_CODENAME
}

dotfiles_linux_release_id() {
  dotfiles_load_os_release || return 1
  if [[ -z ${DOTFILES_OS_RELEASE_ID:-} ]]; then
    echo "unsupported linux: missing ID in /etc/os-release" >&2
    return 1
  fi
  printf '%s\n' "${DOTFILES_OS_RELEASE_ID}"
}

dotfiles_linux_release_codename() {
  dotfiles_load_os_release || return 1
  if [[ -z ${DOTFILES_OS_RELEASE_CODENAME:-} ]]; then
    echo "unsupported linux: missing VERSION_CODENAME" >&2
    return 1
  fi
  printf '%s\n' "${DOTFILES_OS_RELEASE_CODENAME}"
}

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_LOG_PREFIX=bootstrap:debian
# shellcheck source=scripts/lib/platform.sh
source "${ROOT_DIR}/scripts/lib/platform.sh"
# shellcheck source=scripts/lib/common.sh
source "${ROOT_DIR}/scripts/lib/common.sh"
init_sudo_cmd

apply_apt_mirror() {
  local linux_id
  local codename

  linux_id="$(dotfiles_linux_release_id)"
  if [[ "${linux_id}" != "debian" ]]; then
    echo "unsupported debian bootstrap target: ${linux_id}" >&2
    exit 1
  fi

  codename="$(dotfiles_linux_release_codename)"
  local mirror=${DOTFILES_DEBIAN_MIRROR:-http://mirrors.ustc.edu.cn/debian}
  local security_mirror=${DOTFILES_DEBIAN_SECURITY_MIRROR:-http://mirrors.ustc.edu.cn/debian-security}
  local components="main contrib non-free non-free-firmware"
  local source_file=/etc/apt/sources.list.d/debian.sources

  if [[ -f "${source_file}" && ! -f "${source_file}.bak" ]]; then
    "${sudo_cmd[@]}" cp "${source_file}" "${source_file}.bak"
  fi
  if [[ -f "${source_file}" ]]; then
    "${sudo_cmd[@]}" rm -f "${source_file}"
  fi

  write_sources_list /etc/apt/sources.list \
    "deb ${mirror} ${codename} ${components}" \
    "deb ${mirror} ${codename}-updates ${components}" \
    "deb ${mirror} ${codename}-backports ${components}" \
    "deb ${security_mirror} ${codename}-security ${components}"
}

apply_apt_mirror

run_apt_update_once
run_step "apt install init packages" "${sudo_cmd[@]}" apt install -y ca-certificates curl git gnupg zsh vim

if ! command -v chezmoi >/dev/null 2>&1; then
  log "start: chezmoi installer"
  sh -c "$(curl --http1.1 --retry 2 --retry-all-errors --retry-delay "${DOTFILES_RETRY_DELAY:-5}" -fsLS get.chezmoi.io)" -- -b "${HOME}/.local/bin"
  log "done: chezmoi installer"
else
  log "found chezmoi: $(command -v chezmoi)"
fi

export PATH="${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}"
install_mise_from_installer

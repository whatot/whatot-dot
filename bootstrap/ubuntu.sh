#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_LOG_PREFIX=bootstrap:ubuntu
# shellcheck source=scripts/lib/platform
source "${ROOT_DIR}/scripts/lib/platform"
# shellcheck source=scripts/lib/common
source "${ROOT_DIR}/scripts/lib/common"
init_sudo_cmd

apply_apt_mirror() {
  local linux_id
  local codename

  linux_id="$(dotfiles_linux_release_id)"
  if [[ "${linux_id}" != "ubuntu" ]]; then
    echo "unsupported ubuntu bootstrap target: ${linux_id}" >&2
    exit 1
  fi

  codename="$(dotfiles_linux_release_codename)"
  local mirror=${DOTFILES_UBUNTU_MIRROR:-http://mirrors.ustc.edu.cn/ubuntu}
  local components="main restricted universe multiverse"
  local suites=("${codename}" "${codename}-updates" "${codename}-backports" "${codename}-security")
  local lines=()
  local source_file suite

  for suite in "${suites[@]}"; do
    lines+=("deb ${mirror} ${suite} ${components}")
  done

  for source_file in /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/debian.sources; do
    if [[ -f "${source_file}" && ! -f "${source_file}.bak" ]]; then
      "${sudo_cmd[@]}" cp "${source_file}" "${source_file}.bak"
    fi
    if [[ -f "${source_file}" ]]; then
      "${sudo_cmd[@]}" rm -f "${source_file}"
    fi
  done

  write_sources_list /etc/apt/sources.list "${lines[@]}"
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

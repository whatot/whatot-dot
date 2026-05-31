#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
# shellcheck source=scripts/lib/common.sh
source "${ROOT_DIR}/scripts/lib/common.sh"
export HOMEBREW_NO_AUTO_UPDATE="${HOMEBREW_NO_AUTO_UPDATE:-1}"
export HOMEBREW_BOTTLE_DOMAIN="${HOMEBREW_BOTTLE_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles}"
export HOMEBREW_API_DOMAIN="${HOMEBREW_API_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles/api}"
brew_bundle_args=()

if [[ ${DOTFILES_BREW_BUNDLE_VERBOSE:-true} == "true" ]]; then
  brew_bundle_args+=(--verbose)
fi

install_brew() {
  if command -v brew >/dev/null 2>&1; then
    log "found Homebrew: $(command -v brew)"
    return
  fi

  log "install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_brew

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

run_step_retry "brew bundle packages/macos/init.Brewfile" \
  brew bundle "${brew_bundle_args[@]}" --file "${ROOT_DIR}/packages/macos/init.Brewfile"

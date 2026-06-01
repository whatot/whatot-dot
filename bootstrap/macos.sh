#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_LOG_PREFIX=bootstrap:macos
# shellcheck source=scripts/lib/common.sh
source "${ROOT_DIR}/scripts/lib/common.sh"
# shellcheck source=scripts/lib/homebrew.sh
source "${ROOT_DIR}/scripts/lib/homebrew.sh"

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    log "found Homebrew: $(command -v brew)"
    return
  fi

  log "install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_homebrew_init_packages() {
  run_step_retry "brew bundle packages/macos/init.Brewfile" \
    brew bundle "${brew_bundle_args[@]}" --file "${ROOT_DIR}/packages/macos/init.Brewfile"
}

main() {
  dotfiles_init_homebrew_env
  dotfiles_init_brew_bundle_args
  install_homebrew
  dotfiles_load_homebrew_shellenv
  install_homebrew_init_packages
}

main "$@"

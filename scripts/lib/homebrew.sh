#!/usr/bin/env bash

dotfiles_init_homebrew_env() {
  export HOMEBREW_NO_AUTO_UPDATE="${HOMEBREW_NO_AUTO_UPDATE:-1}"
  export HOMEBREW_BOTTLE_DOMAIN="${HOMEBREW_BOTTLE_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles}"
  export HOMEBREW_API_DOMAIN="${HOMEBREW_API_DOMAIN:-https://mirrors.ustc.edu.cn/homebrew-bottles/api}"
}

dotfiles_init_brew_bundle_args() {
  brew_bundle_args=()

  if [[ ${DOTFILES_BREW_BUNDLE_VERBOSE:-true} == "true" ]]; then
    brew_bundle_args+=(--verbose)
  fi
}

dotfiles_load_homebrew_shellenv() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

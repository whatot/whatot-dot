#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"

# shellcheck source=scripts/lib/env
source "${ROOT_DIR}/scripts/lib/env"
# shellcheck source=scripts/lib/test-targets
source "${ROOT_DIR}/scripts/lib/test-targets"

dotfiles_load_private_env

dotfiles_smoke_add_env_if_set() {
  local name=$1

  if [[ -n "${!name:-}" ]]; then
    env_args+=("$2" "${name}$3${!name}")
  fi
}

dotfiles_smoke_add_forwarded_envs() {
  local name
  local prefix=${1:-}
  local separator=${2:-=}

  while IFS= read -r name; do
    dotfiles_smoke_add_env_if_set "${name}" "${prefix}" "${separator}"
  done < <(dotfiles_test_forwarded_env_names)
}

dotfiles_smoke_add_proxy_defaults() {
  local proxy_url=$1
  local prefix=${2:-}
  local separator=${3:-=}

  [[ -n ${HTTP_PROXY:-} ]] || env_args+=("${prefix}HTTP_PROXY${separator}${proxy_url}")
  [[ -n ${HTTPS_PROXY:-} ]] || env_args+=("${prefix}HTTPS_PROXY${separator}${proxy_url}")
  [[ -n ${ALL_PROXY:-} ]] || env_args+=("${prefix}ALL_PROXY${separator}${proxy_url}")
  [[ -n ${http_proxy:-} ]] || env_args+=("${prefix}http_proxy${separator}${proxy_url}")
  [[ -n ${https_proxy:-} ]] || env_args+=("${prefix}https_proxy${separator}${proxy_url}")
  [[ -n ${all_proxy:-} ]] || env_args+=("${prefix}all_proxy${separator}${proxy_url}")
  [[ -n ${NO_PROXY:-} ]] || env_args+=("${prefix}NO_PROXY${separator}localhost,127.0.0.1,::1")
  [[ -n ${no_proxy:-} ]] || env_args+=("${prefix}no_proxy${separator}localhost,127.0.0.1,::1")
}

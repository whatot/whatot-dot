#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/smoke/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

usage() {
  printf 'usage: tests/smoke/orbstack.sh <%s> [--reset]\n\n' "$(dotfiles_test_target_selector true)"
  printf 'Create or reuse fixed OrbStack Linux test machines and run the bootstrap smoke\n'
  printf 'test.\n\n'
  printf 'Machines:\n'
  dotfiles_test_machine_lines
  printf '\nOptions:\n'
  printf '  --reset  delete the target machine before creating it again\n'
}

log() {
  printf "==> %s\n" "$*"
}

add_proxy_envs() {
  local proxy_url=${PROXY_URL:-}

  dotfiles_smoke_add_env_if_set HTTP_PROXY "" "="
  dotfiles_smoke_add_env_if_set HTTPS_PROXY "" "="
  dotfiles_smoke_add_env_if_set ALL_PROXY "" "="
  dotfiles_smoke_add_env_if_set NO_PROXY "" "="
  dotfiles_smoke_add_env_if_set http_proxy "" "="
  dotfiles_smoke_add_env_if_set https_proxy "" "="
  dotfiles_smoke_add_env_if_set all_proxy "" "="
  dotfiles_smoke_add_env_if_set no_proxy "" "="
  dotfiles_smoke_add_env_if_set PROXY_URL "" "="

  if [[ ${USE_PROXY:-true} != "true" || -z "${proxy_url}" ]]; then
    return
  fi

  dotfiles_smoke_add_proxy_defaults "${proxy_url}" "" "="
}

require_orbstack() {
  if ! command -v orbctl >/dev/null 2>&1; then
    echo "orbctl is required. Install OrbStack first." >&2
    exit 1
  fi
}

machine_exists() {
  local machine=$1
  orbctl info "${machine}" >/dev/null 2>&1
}

delete_machine() {
  local machine=$1

  if machine_exists "${machine}"; then
    orbctl delete "${machine}"
  fi
}

ensure_machine() {
  local target=$1
  local machine distro arch

  machine=$(dotfiles_test_machine_for_target "${target}")
  distro=$(dotfiles_test_distro_for_target "${target}")
  arch=$(dotfiles_test_arch_for_target "${target}")

  if machine_exists "${machine}"; then
    log "reuse ${machine}"
    return
  fi

  log "create ${machine} from ${distro} (${arch})"
  orbctl create --arch "${arch}" "${distro}" "${machine}"
}

sync_repo() {
  local machine=$1

  log "sync repository to ${machine}:~/dotfiles-test"
  orbctl run -m "${machine}" rm -rf dotfiles-test
  orbctl run -m "${machine}" mkdir -p dotfiles-test
  orbctl push -m "${machine}" "${ROOT_DIR}/." dotfiles-test/
}

run_smoke_test() {
  local machine=$1
  local target=$2
  local script
  local name
  local env_args=(
    "DOTFILES_HOST=${target}"
    "DOTFILES_GIT_NAME=Dotfiles Test"
    "DOTFILES_GIT_EMAIL=dotfiles-test@example.invalid"
  )

  dotfiles_smoke_add_forwarded_envs "" "="
  add_proxy_envs
  script="$(dotfiles_test_smoke_script "${target}" bootstrap)"

  log "run bootstrap smoke test on ${machine}"
  orbctl run -m "${machine}" --workdir dotfiles-test env "${env_args[@]}" bash -lc "${script}"
}

run_target() {
  local target=$1
  local reset=$2
  local machine

  require_orbstack
  machine=$(dotfiles_test_machine_for_target "${target}")

  if [[ "${reset}" == "true" ]]; then
    delete_machine "${machine}"
  fi

  ensure_machine "${target}"
  sync_repo "${machine}"
  run_smoke_test "${machine}" "${target}"
}

target=${1:-}
reset=false

if [[ -z "${target}" ]]; then
  usage
  exit 1
fi
shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --reset)
      reset=true
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
  shift
done

case "${target}" in
  all)
    while IFS= read -r resolved_target; do
      run_target "${resolved_target}" "${reset}"
    done < <(dotfiles_test_targets)
    ;;
  -h | --help)
    usage
    ;;
  *)
    if dotfiles_test_is_supported_target "${target}"; then
      run_target "${target}" "${reset}"
    else
      echo "unsupported target: ${target}" >&2
      usage
      exit 1
    fi
    ;;
esac

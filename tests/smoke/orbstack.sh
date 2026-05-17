#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
# shellcheck source=scripts/lib/env
source "${ROOT_DIR}/scripts/lib/env"
# shellcheck source=scripts/lib/test-targets
source "${ROOT_DIR}/scripts/lib/test-targets"
dotfiles_load_private_env

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

add_env_if_set() {
  local name=$1

  if [[ -n "${!name:-}" ]]; then
    env_args+=("${name}=${!name}")
  fi
}

add_proxy_envs() {
  local proxy_url=${PROXY_URL:-}
  local name

  for name in HTTP_PROXY HTTPS_PROXY ALL_PROXY NO_PROXY http_proxy https_proxy all_proxy no_proxy PROXY_URL; do
    add_env_if_set "${name}"
  done

  if [[ ${USE_PROXY:-true} != "true" || -z "${proxy_url}" ]]; then
    return
  fi

  [[ -n ${HTTP_PROXY:-} ]] || env_args+=("HTTP_PROXY=${proxy_url}")
  [[ -n ${HTTPS_PROXY:-} ]] || env_args+=("HTTPS_PROXY=${proxy_url}")
  [[ -n ${ALL_PROXY:-} ]] || env_args+=("ALL_PROXY=${proxy_url}")
  [[ -n ${http_proxy:-} ]] || env_args+=("http_proxy=${proxy_url}")
  [[ -n ${https_proxy:-} ]] || env_args+=("https_proxy=${proxy_url}")
  [[ -n ${all_proxy:-} ]] || env_args+=("all_proxy=${proxy_url}")
  [[ -n ${NO_PROXY:-} ]] || env_args+=("NO_PROXY=localhost,127.0.0.1,::1")
  [[ -n ${no_proxy:-} ]] || env_args+=("no_proxy=localhost,127.0.0.1,::1")
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

  while IFS= read -r name; do
    if [[ -n "${!name:-}" ]]; then
      env_args+=("${name}=${!name}")
    fi
  done < <(dotfiles_test_forwarded_env_names)
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

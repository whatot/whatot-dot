#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/smoke-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/smoke-common.sh"

usage() {
  printf 'usage: tests/smoke/container.sh <%s> [bootstrap|packages|devtools]\n\n' \
    "$(dotfiles_test_target_selector true)"
  printf 'Run Linux bootstrap, package, and devtool smoke tests in Docker containers.\n'
}

log() {
  printf "==> %s\n" "$*"
}

require_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "docker is required. OrbStack Docker or Docker Desktop both work." >&2
    exit 1
  fi
}

docker_proxy_url() {
  local url=$1

  url="${url//:\/\/127.0.0.1:/:\/\/host.docker.internal:}"
  url="${url//:\/\/localhost:/:\/\/host.docker.internal:}"
  printf '%s\n' "${url}"
}

add_proxy_url_env_if_set() {
  local name=$1
  local value=${!name:-}

  if [[ -n "${value}" ]]; then
    env_args+=(--env "${name}=$(docker_proxy_url "${value}")")
  fi
}

add_proxy_envs() {
  local proxy_url

  for name in HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy; do
    add_proxy_url_env_if_set "${name}"
  done
  for name in NO_PROXY no_proxy; do
    dotfiles_smoke_add_env_if_set "${name}" --env "="
  done

  if [[ ${USE_PROXY:-true} != "true" || -z ${PROXY_URL:-} ]]; then
    return
  fi

  proxy_url="$(docker_proxy_url "${PROXY_URL}")"
  env_args+=(--env "PROXY_URL=${proxy_url}")
  dotfiles_smoke_add_proxy_defaults "${proxy_url}" --env "="
}

run_target() {
  local target=$1
  local stage=$2
  local image platform command
  local docker_args=()
  local env_args=()
  local name

  require_docker
  image=$(dotfiles_test_image_for_target "${target}")
  platform=$(dotfiles_test_platform_for_target "${target}")
  command=$(dotfiles_test_smoke_script "${target}" "${stage}")

  if [[ "${target}" == "arch-amd64" ]]; then
    docker_args+=(--security-opt seccomp=unconfined)
  fi

  dotfiles_smoke_add_forwarded_envs --env "="
  if [[ "${stage}" != "bootstrap" ]]; then
    env_args+=(--env "DOTFILES_SKIP_MISE_INSTALL=true")
  fi
  add_proxy_envs

  log "run ${target} ${stage} in ${image} (${platform})"
  docker run --rm \
    --platform "${platform}" \
    "${docker_args[@]}" \
    --env "DOTFILES_HOST=${target}" \
    --env "DOTFILES_GIT_NAME=Dotfiles Test" \
    --env "DOTFILES_GIT_EMAIL=dotfiles-test@example.invalid" \
    "${env_args[@]}" \
    --volume "${ROOT_DIR}:/workspace:ro" \
    --workdir /workspace \
    "${image}" \
    bash -lc "${command}"
}

target=${1:-}
stage=${2:-bootstrap}

if [[ -z "${target}" ]]; then
  usage
  exit 1
fi

case "${stage}" in
  bootstrap | packages | devtools) ;;
  *)
    echo "unsupported stage: ${stage}" >&2
    usage
    exit 1
    ;;
esac

case "${target}" in
  all)
    while IFS= read -r resolved_target; do
      run_target "${resolved_target}" "${stage}"
    done < <(dotfiles_test_targets)
    ;;
  -h | --help)
    usage
    ;;
  *)
    if dotfiles_test_is_supported_target "${target}"; then
      run_target "${target}" "${stage}"
    else
      echo "unsupported target: ${target}" >&2
      usage
      exit 1
    fi
    ;;
esac

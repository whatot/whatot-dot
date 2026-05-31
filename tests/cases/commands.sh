#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

dotfiles_check_doctor_failure_output() {
  local tmp_dir
  local env_file
  local output

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  env_file="${tmp_dir}/env"

  cat >"${env_file}" <<'EOF'
DOTFILES_HOST
EOF

  if output="$(DOTFILES_ENV_FILE="${env_file}" bash "${ROOT_DIR}/scripts/doctor" 2>&1)"; then
    printf 'expected doctor to fail for invalid private env\n' >&2
    return 1
  fi

  [[ "${output}" == *"checks:"* ]]
  [[ "${output}" == *"miss private env"* ]]
  [[ "${output}" == *"invalid env line: ${env_file}:1: missing \"=\""* ]]
  [[ "${output}" == *"miss host plan"* ]]
  [[ "${output}" == *"skipped: private env check failed"* ]]
}

dotfiles_check_task_wiring() {
  local output
  local outdated_run

  output="$(mise tasks)"
  outdated_run="$(awk '
    $0 == "[tasks.outdated]" { in_block=1; next }
    /^\[tasks\./ && in_block { exit }
    in_block && $1 == "run" { print $0; exit }
  ' "${ROOT_DIR}/mise.toml")"

  [[ "${output}" == *"outdated                   Refresh metadata and show available package and mise updates"* ]]
  [[ "${output}" == *"outdated:packages          Refresh metadata and show available operating system package updates"* ]]
  [[ "${output}" == *"outdated:mise              Refresh metadata and show available mise tool updates"* ]]
  [[ "${outdated_run}" == 'run = "scripts/outdated"' ]]
}

main() {
  run_step "check doctor failure output" dotfiles_check_doctor_failure_output
  run_step "check task wiring" dotfiles_check_task_wiring
}

main "$@"

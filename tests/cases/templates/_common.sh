#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd -P)"

# shellcheck source=tests/cases/_common.sh
source "${ROOT_DIR}/tests/cases/_common.sh"

dotfiles_tmpl_render() {
  local template_path=$1
  shift
  local data_file=
  local entry
  local name
  local value

  if [[ $# -gt 0 && -f "$1" ]]; then
    data_file=$1
    shift
  fi

  (
    while IFS='=' read -r name _; do
      if [[ "${name}" == DOTFILES_* ]]; then
        unset "${name}"
      fi
    done < <(env)

    for entry in "$@"; do
      name=${entry%%=*}
      value=${entry#*=}
      export "${name}=${value}"
    done

    if [[ -n "${data_file}" ]]; then
      dotfiles_check_run_tool chezmoi execute-template \
        --source "${ROOT_DIR}" \
        --override-data-file "${data_file}" \
        --file "${template_path}"
    else
      dotfiles_check_run_tool chezmoi execute-template \
        --source "${ROOT_DIR}" \
        --file "${template_path}"
    fi
  )
}

dotfiles_tmpl_assert_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" != *"${needle}"* ]]; then
    printf 'missing expected snippet:\n%s\n' "${needle}" >&2
    return 1
  fi
}

dotfiles_tmpl_assert_not_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" == *"${needle}"* ]]; then
    printf 'unexpected snippet present:\n%s\n' "${needle}" >&2
    return 1
  fi
}

dotfiles_tmpl_assert_bash_syntax() {
  local content=$1
  local tmp_dir
  local tmp_file

  tmp_dir="$(mktemp -d)"
  tmp_file="${tmp_dir}/rendered.sh"
  printf '%s\n' "${content}" >"${tmp_file}"
  bash -n "${tmp_file}"
  dotfiles_check_run_tool shellcheck "${tmp_file}"
  rm -rf "${tmp_dir}"
}

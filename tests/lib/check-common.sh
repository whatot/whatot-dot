#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"

# shellcheck source=scripts/lib/env
source "${ROOT_DIR}/scripts/lib/env"
# shellcheck source=scripts/lib/plan
source "${ROOT_DIR}/scripts/lib/plan"
# shellcheck source=scripts/lib/test-targets
source "${ROOT_DIR}/scripts/lib/test-targets"
# shellcheck source=scripts/lib/common
source "${ROOT_DIR}/scripts/lib/common"

dotfiles_check_load_env() {
  dotfiles_load_private_env
}

dotfiles_check_run_tool() {
  local tool=$1
  shift

  if command -v mise >/dev/null 2>&1; then
    mise exec -- "${tool}" "$@"
  elif command -v "${tool}" >/dev/null 2>&1; then
    "${tool}" "$@"
  else
    echo "${tool} is required. Run mise install first." >&2
    return 1
  fi
}

dotfiles_check_collect_shell_files() {
  local dir

  for dir in scripts bootstrap tests; do
    if [[ -d "${ROOT_DIR}/${dir}" ]]; then
      find "${ROOT_DIR}/${dir}" -type f
    fi
  done
}

dotfiles_check_render_template() {
  local source_path=$1
  local output_path=$2
  local host_data_file=$3

  dotfiles_check_run_tool chezmoi execute-template \
    --source "${ROOT_DIR}" \
    --override-data-file "${host_data_file}" \
    --file "${source_path}" >"${output_path}"
}

dotfiles_check_write_vim_plug_stub() {
  local output_path=$1

  cat >"${output_path}" <<'EOF'
function! plug#begin(...) abort
  command! -nargs=* Plug call s:plug(<q-args>)
endfunction

function! s:plug(...) abort
endfunction

function! plug#end() abort
endfunction
EOF
}

dotfiles_check_run_dprint() {
  dotfiles_check_run_tool dprint check --incremental=false --excludes ".cache"
}

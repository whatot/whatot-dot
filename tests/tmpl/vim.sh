#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
VIMRC_TEMPLATE="${ROOT_DIR}/home/dot_vimrc.tmpl"
HOOK_TEMPLATE="${ROOT_DIR}/home/run_onchange_after_vim_plug.sh.tmpl"

render_template() {
  local template_path=$1
  local data_file=${2:-}

  if [[ -n "${data_file}" ]]; then
    chezmoi execute-template --source "${ROOT_DIR}" --override-data-file "${data_file}" --file "${template_path}"
  else
    chezmoi execute-template --source "${ROOT_DIR}" --file "${template_path}"
  fi
}

assert_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" != *"${needle}"* ]]; then
    printf 'missing expected snippet:\n%s\n' "${needle}" >&2
    return 1
  fi
}

case_vimrc_defaults_to_minimal() {
  local output

  output="$(render_template "${VIMRC_TEMPLATE}")"
  assert_contains "${output}" "let g:dotfiles_vim_profile = 'minimal'"
  assert_contains "${output}" 'source ~/.vim/minimal.vim'
}

case_vimrc_uses_tiny_profile_when_host_requests_it() {
  local output

  output="$(render_template "${VIMRC_TEMPLATE}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  assert_contains "${output}" "let g:dotfiles_vim_profile = 'tiny'"
  assert_contains "${output}" 'source ~/.vim/tiny.vim'
}

case_vim_plug_hook_defaults_to_minimal() {
  local output

  output="$(render_template "${HOOK_TEMPLATE}")"
  assert_contains "${output}" 'vim_profile="minimal"'
  assert_contains "${output}" '# tiny.vim sha256: '
}

case_vim_plug_hook_uses_tiny_profile() {
  local output

  output="$(render_template "${HOOK_TEMPLATE}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  assert_contains "${output}" 'vim_profile="tiny"'
  assert_contains "${output}" "vim -Nu \"\${HOME}/.vimrc\" -n +'PlugInstall --sync' +qall"
}

main() {
  case_vimrc_defaults_to_minimal
  case_vimrc_uses_tiny_profile_when_host_requests_it
  case_vim_plug_hook_defaults_to_minimal
  case_vim_plug_hook_uses_tiny_profile
}

main "$@"

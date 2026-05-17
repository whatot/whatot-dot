#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/tmpl-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/tmpl-common.sh"

VIMRC_TEMPLATE="${ROOT_DIR}/home/dot_vimrc.tmpl"
HOOK_TEMPLATE="${ROOT_DIR}/home/run_onchange_after_vim_plug.sh.tmpl"

case_vimrc_defaults_to_minimal() {
  local output

  output="$(dotfiles_tmpl_render "${VIMRC_TEMPLATE}")"
  dotfiles_tmpl_assert_contains "${output}" "let g:dotfiles_vim_profile = 'minimal'"
  dotfiles_tmpl_assert_contains "${output}" 'source ~/.vim/minimal.vim'
}

case_vimrc_uses_tiny_profile_when_host_requests_it() {
  local output

  output="$(dotfiles_tmpl_render "${VIMRC_TEMPLATE}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" "let g:dotfiles_vim_profile = 'tiny'"
  dotfiles_tmpl_assert_contains "${output}" 'source ~/.vim/tiny.vim'
}

case_vim_plug_hook_defaults_to_minimal() {
  local output

  output="$(dotfiles_tmpl_render "${HOOK_TEMPLATE}")"
  dotfiles_tmpl_assert_contains "${output}" 'vim_profile="minimal"'
  dotfiles_tmpl_assert_contains "${output}" '# tiny.vim sha256: '
}

case_vim_plug_hook_uses_tiny_profile() {
  local output

  output="$(dotfiles_tmpl_render "${HOOK_TEMPLATE}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'vim_profile="tiny"'
  dotfiles_tmpl_assert_contains "${output}" "vim -Nu \"\${HOME}/.vimrc\" -n +'PlugInstall --sync' +qall"
}

main() {
  case_vimrc_defaults_to_minimal
  case_vimrc_uses_tiny_profile_when_host_requests_it
  case_vim_plug_hook_defaults_to_minimal
  case_vim_plug_hook_uses_tiny_profile
}

main "$@"

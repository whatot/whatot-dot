#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/templates/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/run_onchange_after_fish_plugins.sh.tmpl"

case_fish_plugins_hook_renders_to_valid_bash() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}")"
  dotfiles_tmpl_assert_bash_syntax "${output}"
  dotfiles_tmpl_assert_contains "${output}" '# fish_plugins sha256: '
  dotfiles_tmpl_assert_contains "${output}" 'fisher update'
}

main() {
  case_fish_plugins_hook_renders_to_valid_bash
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/tmpl-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/tmpl-common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/dot_config/rtk/config.toml.tmpl"

current_kernel() {
  uname -s
}

case_uses_platform_specific_database_path() {
  local output
  local home_dir

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}")"
  home_dir="${HOME}"

  if [[ "$(current_kernel)" == "Darwin" ]]; then
    dotfiles_tmpl_assert_contains "${output}" "database_path = \"${home_dir}/Library/Caches/rtk/tracking.db\""
    dotfiles_tmpl_assert_not_contains "${output}" "database_path = \"${home_dir}/.cache/rtk/tracking.db\""
  else
    dotfiles_tmpl_assert_contains "${output}" "database_path = \"${home_dir}/.cache/rtk/tracking.db\""
    dotfiles_tmpl_assert_not_contains "${output}" "database_path = \"${home_dir}/Library/Caches/rtk/tracking.db\""
  fi
}

case_keeps_expected_defaults() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}")"
  dotfiles_tmpl_assert_contains "${output}" 'exclude_commands = ["curl", "playwright"]'
  dotfiles_tmpl_assert_contains "${output}" 'transparent_prefixes = ["sudo"]'
  dotfiles_tmpl_assert_contains "${output}" $'[telemetry]\nenabled = false'
  dotfiles_tmpl_assert_contains "${output}" 'passthrough_max_chars = 2000'
}

main() {
  case_uses_platform_specific_database_path
  case_keeps_expected_defaults
}

main "$@"

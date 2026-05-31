#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/templates/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/dot_config/ghostty/config.ghostty.tmpl"

current_kernel() {
  uname -s
}

case_default_font_size_without_host_data() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}")"
  dotfiles_tmpl_assert_contains "${output}" 'font-size = 14'
}

case_host_data_overrides_font_size() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'font-size = 13'
}

case_host_data_can_set_command() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'command = /opt/homebrew/bin/fish --login'
}

case_platform_specific_settings_follow_rendering_os() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/debian-amd64.toml")"

  if [[ "$(current_kernel)" == "Darwin" ]]; then
    dotfiles_tmpl_assert_contains "${output}" 'macos-titlebar-style = transparent'
    dotfiles_tmpl_assert_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
  else
    dotfiles_tmpl_assert_not_contains "${output}" 'macos-titlebar-style = transparent'
    dotfiles_tmpl_assert_not_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
  fi
}

case_macos_host_keeps_platform_specific_settings() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'macos-titlebar-style = transparent'
  dotfiles_tmpl_assert_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
}

main() {
  case_default_font_size_without_host_data
  case_host_data_overrides_font_size
  case_host_data_can_set_command
  case_platform_specific_settings_follow_rendering_os
  case_macos_host_keeps_platform_specific_settings
}

main "$@"

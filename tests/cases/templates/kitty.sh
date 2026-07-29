#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/templates/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/dot_config/kitty/kitty.conf.tmpl"
LAUNCH_SERVICES_TEMPLATE="${ROOT_DIR}/home/dot_config/kitty/macos-launch-services-cmdline.tmpl"
SESSION_WATCHER="${ROOT_DIR}/home/dot_config/kitty/auto_session.py"
SESSION_SEED="${ROOT_DIR}/home/dot_config/kitty/create_last-session.kitty-session"

current_kernel() {
  uname -s
}

case_default_font_size_without_host_data() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}")"
  dotfiles_tmpl_assert_contains "${output}" 'font_size 14'
}

case_host_data_overrides_font_size() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'font_size 13'
}

case_host_data_can_set_command() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'shell /opt/homebrew/bin/fish --login'
}

case_platform_specific_settings_follow_rendering_os() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/debian-amd64.toml")"

  if [[ "$(current_kernel)" == "Darwin" ]]; then
    dotfiles_tmpl_assert_contains "${output}" 'macos_titlebar_color background'
    dotfiles_tmpl_assert_contains "${output}" 'macos_option_as_alt both'
  else
    dotfiles_tmpl_assert_not_contains "${output}" 'macos_titlebar_color background'
    dotfiles_tmpl_assert_not_contains "${output}" 'macos_option_as_alt both'
  fi
}

case_macos_host_keeps_platform_specific_settings() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'macos_titlebar_color background'
  dotfiles_tmpl_assert_contains "${output}" 'macos_option_as_alt both'
}

case_macos_gui_starts_maximized() {
  local output

  output="$(dotfiles_tmpl_render "${LAUNCH_SERVICES_TEMPLATE}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" '--start-as=maximized'
}

case_uses_laptop_tab_layout() {
  local output

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_contains "${output}" 'tab_bar_edge top'
  dotfiles_tmpl_assert_contains "${output}" 'tab_bar_min_tabs 2'
  dotfiles_tmpl_assert_contains "${output}" 'window_padding_width 4 6'
  dotfiles_tmpl_assert_contains "${output}" 'active_tab_foreground #ffffff'
  dotfiles_tmpl_assert_contains "${output}" 'active_tab_background #21262d'
  dotfiles_tmpl_assert_contains "${output}" 'active_tab_font_style normal'
  dotfiles_tmpl_assert_contains "${output}" 'inactive_tab_foreground #8b949e'
  dotfiles_tmpl_assert_contains "${output}" 'tab_title_max_length 28'
  dotfiles_tmpl_assert_contains "${output}" 'tab_title_template " {index}: {title} "'
  dotfiles_tmpl_assert_contains "${output}" 'map cmd+1 goto_tab 1'
  dotfiles_tmpl_assert_contains "${output}" 'map cmd+9 goto_tab 9'
}

case_restores_last_session_on_startup() {
  local output
  local seed
  local watcher

  output="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  seed="$(cat "${SESSION_SEED}")"
  watcher="$(cat "${SESSION_WATCHER}")"

  dotfiles_tmpl_assert_contains "${output}" 'watcher auto_session.py'
  dotfiles_tmpl_assert_contains \
    "${output}" \
    "startup_session \${HOME}/.config/kitty/last-session.kitty-session"
  dotfiles_tmpl_assert_contains "${watcher}" 'def on_quit('
  dotfiles_tmpl_assert_contains "${watcher}" 'if data.get("confirmed"):'
  dotfiles_tmpl_assert_contains "${watcher}" 'save_as_session --save-only'

  if [[ "${seed}" != "launch" ]]; then
    printf 'unexpected initial kitty session:\n%s\n' "${seed}" >&2
    return 1
  fi
}

main() {
  case_default_font_size_without_host_data
  case_host_data_overrides_font_size
  case_host_data_can_set_command
  case_platform_specific_settings_follow_rendering_os
  case_macos_host_keeps_platform_specific_settings
  case_macos_gui_starts_maximized
  case_uses_laptop_tab_layout
  case_restores_last_session_on_startup
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd -P)"
TEMPLATE_PATH="${ROOT_DIR}/home/dot_config/ghostty/config.ghostty.tmpl"

render_template() {
  local data_file=${1:-}
  shift || true

  if [[ -n "${data_file}" ]]; then
    env "$@" chezmoi execute-template --source "${ROOT_DIR}" --override-data-file "${data_file}" --file "${TEMPLATE_PATH}"
  else
    env "$@" chezmoi execute-template --source "${ROOT_DIR}" --file "${TEMPLATE_PATH}"
  fi
}

current_kernel() {
  uname -s
}

assert_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" != *"${needle}"* ]]; then
    printf 'missing expected snippet:\n%s\n' "${needle}" >&2
    return 1
  fi
}

assert_not_contains() {
  local haystack=$1
  local needle=$2

  if [[ "${haystack}" == *"${needle}"* ]]; then
    printf 'unexpected snippet present:\n%s\n' "${needle}" >&2
    return 1
  fi
}

case_default_font_size_without_host_data() {
  local output

  output="$(render_template)"
  assert_contains "${output}" 'font-size = 14'
}

case_host_data_overrides_font_size() {
  local output

  output="$(render_template "${ROOT_DIR}/hosts/macos-arm64.toml")"
  assert_contains "${output}" 'font-size = 13'
}

case_platform_specific_settings_follow_rendering_os() {
  local output

  output="$(render_template "${ROOT_DIR}/hosts/ubuntu-amd64.toml")"

  if [[ "$(current_kernel)" == "Darwin" ]]; then
    assert_contains "${output}" 'macos-titlebar-style = transparent'
    assert_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
  else
    assert_not_contains "${output}" 'macos-titlebar-style = transparent'
    assert_not_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
  fi
}

case_macos_host_keeps_platform_specific_settings() {
  local output

  output="$(render_template "${ROOT_DIR}/hosts/macos-arm64.toml")"
  assert_contains "${output}" 'macos-titlebar-style = transparent'
  assert_contains "${output}" 'macos-titlebar-proxy-icon = hidden'
}

main() {
  case_default_font_size_without_host_data
  case_host_data_overrides_font_size
  case_platform_specific_settings_follow_rendering_os
  case_macos_host_keeps_platform_specific_settings
}

main "$@"

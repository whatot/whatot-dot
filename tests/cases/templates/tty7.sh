#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/templates/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

TEMPLATE_PATH="${ROOT_DIR}/home/dot_config/private_tty7/modify_config.json.tmpl"

run_modifier() {
  local data_file=$1
  local input=$2
  local modifier

  modifier="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${data_file}")"
  printf '%s' "${input}" | sh -c "${modifier}"
}

case_rendered_modifier_is_valid_shell() {
  local modifier

  modifier="$(dotfiles_tmpl_render "${TEMPLATE_PATH}" "${ROOT_DIR}/hosts/macos-arm64.toml")"
  dotfiles_tmpl_assert_bash_syntax "${modifier}"
}

case_empty_input_creates_valid_config() {
  local output

  output="$(run_modifier "${ROOT_DIR}/hosts/macos-arm64.toml" '')"
  jq -e '
    .font_family == "JetBrainsMono Nerd Font"
    and .font_size == 13
    and .shell == {"program":"/opt/homebrew/bin/fish","args":["--login"]}
    and .history_search == false
    and .restore_agent_sessions == true
  ' >/dev/null <<<"${output}"
}

case_preserves_tty7_owned_data() {
  local input
  local output

  input='{
    "font_family": "Hack",
    "font_size": 15.0,
    "theme_preset": "harbor",
    "keybindings": {"NewTab": "ctrl-t"},
    "ssh_profiles": [{"id": "profile-1", "name": "dev"}],
    "ssh_profile_frecency": {"profile-1": {"count": 3, "last_used": 42}},
    "command_frecency": {"NewTab": {"count": 7, "last_used": 84}},
    "future_setting": {"enabled": true}
  }'
  output="$(run_modifier "${ROOT_DIR}/hosts/macos-arm64.toml" "${input}")"

  jq -e '
    .font_family == "JetBrainsMono Nerd Font"
    and .font_size == 13
    and .theme_preset == "one_dark_pro"
    and .keybindings == {"NewTab":"ctrl-t"}
    and .ssh_profiles == [{"id":"profile-1","name":"dev"}]
    and .ssh_profile_frecency == {"profile-1":{"count":3,"last_used":42}}
    and .command_frecency == {"NewTab":{"count":7,"last_used":84}}
    and .future_setting == {"enabled":true}
  ' >/dev/null <<<"${output}"
}

case_modifier_is_idempotent() {
  local first
  local second

  first="$(run_modifier "${ROOT_DIR}/hosts/macos-arm64.toml" '{"command_frecency":{"NewTab":{"count":1,"last_used":2}}}')"
  second="$(run_modifier "${ROOT_DIR}/hosts/macos-arm64.toml" "${first}")"

  if [[ "${first}" != "${second}" ]]; then
    printf 'tty7 modifier is not idempotent\n' >&2
    return 1
  fi
}

case_rejects_invalid_json() {
  if run_modifier "${ROOT_DIR}/hosts/macos-arm64.toml" 'not-json' >/dev/null 2>&1; then
    printf 'tty7 modifier accepted invalid JSON\n' >&2
    return 1
  fi
}

main() {
  case_rendered_modifier_is_valid_shell
  case_empty_input_creates_valid_config
  case_preserves_tty7_owned_data
  case_modifier_is_idempotent
  case_rejects_invalid_json
}

main "$@"

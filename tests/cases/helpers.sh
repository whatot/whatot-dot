#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/cases/_common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/_common.sh"

dotfiles_check_validate_library_helpers() {
  local tmp_dir
  local host_file
  local env_file
  local packages_csv
  local devtools_csv
  local target_selector
  local output

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  host_file="${tmp_dir}/host.toml"
  env_file="${tmp_dir}/env"

  cat >"${host_file}" <<'EOF'
packages = [
  "base",
  "dev", # inline comment stays valid
  "desktop",
]
devtools = ["rust-system", "go-tools"]
EOF

  packages_csv="$(dotfiles_array_from_file "${host_file}" packages | paste -sd, -)"
  devtools_csv="$(dotfiles_array_from_file "${host_file}" devtools | paste -sd, -)"
  target_selector="$(dotfiles_test_target_selector true)"

  [[ "${packages_csv}" == "base,dev,desktop" ]]
  [[ "${devtools_csv}" == "rust-system,go-tools" ]]
  [[ "${target_selector}" == "debian-amd64|arch-amd64|all" ]]
  dotfiles_test_is_supported_target debian-amd64
  if dotfiles_test_is_supported_target macos-arm64; then
    return 1
  fi

  cat >"${env_file}" <<'EOF'
DOTFILES_SAMPLE_ONE=value
DOTFILES_SAMPLE_TWO="two words"
DOTFILES_SAMPLE_THREE='quoted value'
EOF

  output="$(DOTFILES_ENV_FILE="${env_file}" bash -lc '
    source "'"${ROOT_DIR}"'/scripts/lib/env.sh"
    dotfiles_load_private_env
    printf "%s|%s|%s\n" "${DOTFILES_SAMPLE_ONE}" "${DOTFILES_SAMPLE_TWO}" "${DOTFILES_SAMPLE_THREE}"
  ')"
  [[ "${output}" == "value|two words|quoted value" ]]

  cat >"${env_file}" <<'EOF'
DOTFILES_OK=value
BROKEN LINE
EOF

  if output="$(DOTFILES_ENV_FILE="${env_file}" bash -lc '
    source "'"${ROOT_DIR}"'/scripts/lib/env.sh"
    dotfiles_load_private_env
  ' 2>&1)"; then
    printf 'expected invalid env file to fail\n' >&2
    return 1
  fi
  [[ "${output}" == *"invalid env line:"* ]]
  [[ "${output}" == *"${env_file}:2: missing \"=\""* ]]
}

main() {
  run_step "validate helper parsers" dotfiles_check_validate_library_helpers
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

dotfiles_check_validate_library_helpers() {
  local tmp_dir
  local host_file
  local packages_csv
  local devtools_csv
  local target_selector

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir:-}"' EXIT
  host_file="${tmp_dir}/host.toml"

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
  [[ "${target_selector}" == "ubuntu-amd64|debian-amd64|arch-amd64|ubuntu-arm64|all" ]]
  dotfiles_test_is_supported_target ubuntu-amd64
  if dotfiles_test_is_supported_target macos-arm64; then
    return 1
  fi
}

main() {
  run_step "validate helper parsers" dotfiles_check_validate_library_helpers
}

main "$@"

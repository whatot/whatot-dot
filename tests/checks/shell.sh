#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

main() {
  local shellcheck_files=()
  local shell_format_files=()
  local shell_file

  while IFS= read -r shell_file; do
    shellcheck_files+=("${shell_file}")
  done < <(dotfiles_check_collect_shell_files | sort -u)

  while IFS= read -r shell_file; do
    shell_format_files+=("${shell_file}")
  done < <(dotfiles_check_collect_shell_format_files | sort -u)

  if [[ ${#shellcheck_files[@]} -gt 0 ]]; then
    run_step "shellcheck scripts" dotfiles_check_run_tool shellcheck -x "${shellcheck_files[@]}"
  fi

  if [[ ${#shell_format_files[@]} -gt 0 ]]; then
    run_step "shfmt check scripts" dotfiles_check_run_tool shfmt -d -i 2 -ci "${shell_format_files[@]}"
  fi
}

main "$@"

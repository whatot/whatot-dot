#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

main() {
  local template_case

  "${ROOT_DIR}/tests/cases/rendered.sh"
  "${ROOT_DIR}/tests/cases/helpers.sh"
  "${ROOT_DIR}/tests/cases/commands.sh"
  "${ROOT_DIR}/tests/cases/codex-skills.sh"

  while IFS= read -r template_case; do
    printf '[tmpl] %s\n' "${template_case#"${ROOT_DIR}"/}"
    bash "${template_case}"
  done < <(find "${ROOT_DIR}/tests/cases/templates" -maxdepth 1 -type f -name '*.sh' ! -name '_*.sh' | sort)
}

main "$@"

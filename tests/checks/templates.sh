#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=tests/lib/check-common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)/lib/check-common.sh"

main() {
  run_step "test templates" bash "${ROOT_DIR}/tests/tmpl/run"
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

root="${1:-$(pwd)}"

for dir in "${root}"/*; do
  [[ -d "${dir}" ]] || continue
  if [[ -f "${dir}/pom.xml" ]]; then
    echo "clean ${dir}"
    (cd "${dir}" && mvn clean -o)
  else
    echo "skip ${dir}: no pom.xml"
  fi
done

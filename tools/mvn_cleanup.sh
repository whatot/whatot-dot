#!/usr/bin/env bash
set -uxe
shopt -s nullglob

SCRIPT_PATH=$(
  cd "$(dirname "$0")" || return
  pwd -P
)

for dir in "${SCRIPT_PATH}"/*; do
  if [[ -d "${dir}" ]]; then
    cd "${dir}"
    if [[ -f pom.xml ]]; then
      mvn clean -o
    else
      echo "skip no pom project"
    fi
    cd ..
  fi
done

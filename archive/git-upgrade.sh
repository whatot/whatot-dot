#!/usr/bin/env bash
set -euo pipefail

root="${1:-$(pwd)}"

find "${root}" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r dir; do
  if [[ -d "${dir}/.git" ]]; then
    echo ">>> update ${dir}"
    git -C "${dir}" pull
    git -C "${dir}" submodule update --init --recursive
    git -C "${dir}" gc
  elif [[ -d "${dir}/.hg" ]]; then
    echo ">>> update ${dir}"
    (cd "${dir}" && hg pull && hg update)
  fi
done

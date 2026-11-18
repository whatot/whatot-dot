#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'usage: %s [directory]\n\nCreate <directory>.iso and its SHA-256 checksum (default: delivery).\n' "$0"
}

if [[ ${1:-} == --help || ${1:-} == -h ]]; then
  usage
  exit 0
fi
if [[ $# -gt 1 ]]; then
  usage >&2
  exit 2
fi

dir="${1:-delivery}"
while [[ "${dir}" != / && "${dir}" == */ ]]; do
  dir="${dir%/}"
done

if [[ ! -d "${dir}" ]]; then
  printf 'Source directory does not exist: %s\n' "${dir}" >&2
  exit 1
fi

ISO_PATH="${dir}.iso"
ISO_SHA_PATH="${dir}.iso.sha256sum"

if [[ -e "${ISO_PATH}" || -e "${ISO_SHA_PATH}" ]]; then
  printf 'Output already exists: %s or %s\n' "${ISO_PATH}" "${ISO_SHA_PATH}" >&2
  exit 1
fi

echo "step1: create ${ISO_PATH} from ${dir}"
hdiutil makehybrid -iso -joliet -o "${ISO_PATH}" "${dir}"

echo "step2: generate sha256sum"
shasum -a 256 "${ISO_PATH}" >"${ISO_SHA_PATH}"

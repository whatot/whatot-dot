#!/usr/bin/env bash
set -euo pipefail

dir="${1:-delivery}"
DMG_PATH="${dir}.dmg"
ISO_PATH="${dir}.iso"
ISO_CDR_PATH="${dir}.iso.cdr"
ISO_SHA_PATH="${dir}.iso.sha256sum"

echo "step1: create ${DMG_PATH} from ${dir} with Disk Utility first"
echo "step2: convert dmg to iso.cdr"
hdiutil convert "${DMG_PATH}" -format UDTO -o "${ISO_PATH}"

echo "step3: convert iso.cdr to iso"
hdiutil makehybrid -iso -joliet -o "${ISO_PATH}" "${ISO_CDR_PATH}"

echo "step4: generate sha256sum"
shasum -a 256 "${ISO_PATH}" >"${ISO_SHA_PATH}"

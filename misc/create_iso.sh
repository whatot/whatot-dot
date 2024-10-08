#!/usr/bin/env bash
set -xue

if [[ "$#" -eq 0 ]]; then
  dir="delivery"
else
  dir="$1"
fi

DMG_PATH="${dir}.dmg"
ISO_PATH="${dir}.iso"
ISO_CDR_PATH="${dir}.iso.cdr"
ISO_SHA_PATH="${dir}.iso.sha256sum"

echo "step1: convert dir to dmg by disk-utility"
#create dmg by disk-utility，磁盘工具->文件->新建映像->基于文件夹新建映像

echo "step2: convert dmg to iso.cdr"
hdiutil convert "${DMG_PATH}" -format UDTO -o "${ISO_PATH}"

echo "step3: convert iso.cdr to iso"
hdiutil makehybrid -iso -joliet -o "${ISO_PATH}" "${ISO_CDR_PATH}"

echo "step4: generate sha256sum"
sha256sum "${ISO_PATH}" >"${ISO_SHA_PATH}"

#!/bin/bash
set -aux

WRAPPER_NAME="emacs.wrapper"
LOCAL_PATH=$(dirname "$(readlink -f "$0")")"/${WRAPPER_NAME}"
TARGET_PATH="/usr/bin/${WRAPPER_NAME}"

if [[ ! -f "${TARGET_PATH}" ]]; then
    sudo cp "${LOCAL_PATH}" "${TARGET_PATH}"
    sudo chmod +x "${TARGET_PATH}"
fi


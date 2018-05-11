#!/bin/bash
set -x

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

ln -sf "${SCRIPT_PATH}"/zshrc ~/.zshrc
ln -sf "${SCRIPT_PATH}"/zshenv ~/.zshenv

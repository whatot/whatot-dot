#!/bin/bash
set -x

PATH_NOW=$(pwd)

ln -sf "${PATH_NOW}"/zsh/zshrc ~/.zshrc
ln -sf "${PATH_NOW}"/zsh/zshenv ~/.zshenv

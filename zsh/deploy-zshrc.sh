#!/bin/bash
set -x

PATH_NOW=$(pwd)

ln -sf "${PATH_NOW}"/zshrc ~/.zshrc
ln -sf "${PATH_NOW}"/zshenv ~/.zshenv

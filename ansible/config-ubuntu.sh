#!/usr/bin/env bash
set -eux

# https://launchpad.net/~ubuntu-elisp/+archive/ubuntu/ppa
# sudo add-apt-repository ppa:ubuntu-elisp/ppa
# sudo apt install emacs-snapshot

sudo apt update
sudo apt install vim zsh git curl zsh openssh-server htop jq
sudo apt install libssl-dev build-essential pkg-config zlib1g-dev cmake

# jq example
# cat Cargo.lock | toml2json | jq '.package | length'
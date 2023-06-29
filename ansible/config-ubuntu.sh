#!/usr/bin/env bash
set -eux

# https://launchpad.net/~kelleyk/+archive/ubuntu/emacs
# sudo add-apt-repository ppa:kelleyk/emacs
# sudo apt install emacs28-nativecomp
#
# https://launchpad.net/~maveonair/+archive/ubuntu/helix-editor
# sudo add-apt-repository ppa:maveonair/helix-editor
# sudo apt install helix

sudo apt update
sudo apt install vim zsh git curl zsh openssh-server htop jq
sudo apt install libssl-dev build-essential pkg-config zlib1g-dev cmake

# jq example
# cat Cargo.lock | toml2json | jq '.package | length'

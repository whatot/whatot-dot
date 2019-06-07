#!/usr/bin/env bash
set -eux

# https://launchpad.net/~ubuntu-elisp/+archive/ubuntu/ppa
sudo add-apt-repository ppa:ubuntu-elisp/ppa

sudo apt update
sudo apt install vim zsh git curl zsh openssh-server htop
sudo apt install libssl-dev build-essential pkg-config zlib1g-dev cmake

sudo apt install emacs-snapshot

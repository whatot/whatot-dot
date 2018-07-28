#!/usr/bin/env bash
set -eux

# https://launchpad.net/~ubuntu-elisp/+archive/ubuntu/ppa

sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt install emacs-snapshot


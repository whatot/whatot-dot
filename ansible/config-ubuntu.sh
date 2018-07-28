#!/usr/bin/env bash
set -eux

sudo apt update
sudo apt install vim zsh git curl zsh openssh-server htop
sudo apt install libssl-dev build-essential pkg-config zlib1g-dev cmake

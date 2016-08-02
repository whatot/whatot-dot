#!/usr/bin/env bash
set -x

sudo sed -i '/ustc/s/^#//' /etc/pacman.d/mirrorlist
sudo pacman -S ansible python2

ansible-playbook arch.yml --extra-vars "default_user=$USER remote_user=$USER"

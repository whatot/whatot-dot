#!/usr/bin/env bash
set -x

sudo sed -i '/ustc/s/^#//' /etc/pacman.d/mirrorlist
sudo pacman -S ansible python2

ansible-playbook ansible.yml --extra-vars "sudoer_user=$USER remote_user=$USER"

#!/usr/bin/env bash
set -x

sudo sed -i '/ustc/s/^#//' /etc/pacman.d/mirrorlist
sudo pacman -S ansible python2

ansible-playbook arch.yml --extra-vars "default_user=$USER remote_user=$USER"

echo "fcitx-setup for gnome3"
cat << EndOfMessage
gsettings set \\
  org.gnome.settings-daemon.plugins.xsettings overrides \\
  "{'Gtk/IMModule':<'fcitx'>}"
EndOfMessage

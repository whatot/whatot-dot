#!/usr/bin/env bash
set -eux

sudo sed -i '/ustc/s/^#//' /etc/pacman.d/mirrorlist

if [ ! -f "/usr/bin/ansible" ]; then
    sudo pacman -S --noconfirm ansible
fi

ansible-playbook arch.yml -i hosts --extra-vars "default_user=$USER"

echo "fcitx-setup for gnome3"
cat << EOF
gsettings set \\
  org.gnome.settings-daemon.plugins.xsettings overrides \\
  "{'Gtk/IMModule':<'fcitx'>}"
EOF

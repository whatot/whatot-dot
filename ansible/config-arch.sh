#!/usr/bin/env bash
set -eux

sudo sed -i '/ustc/s/^#//' /etc/pacman.d/mirrorlist

if [ ! -f "/usr/bin/ansible" ]; then
    sudo pacman -Syy --noconfirm ansible
fi

time ansible-playbook arch.yml -i hosts.yml --extra-vars "default_user=$USER"

echo "fcitx-setup for gnome3"
cat <<EOF
gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule':<'fcitx'>}"

gsettings set org.gnome.shell.keybindings switch-to-application-1 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "[]"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "[]"

EOF

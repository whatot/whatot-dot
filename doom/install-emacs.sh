#!/bin/bash
set -eux

function for_arch() {
    sudo pacman -S emacs-wayland
}

function for_ubuntu() {
    PPA_NAME=$1
    PKG_NAME=$2

    sudo add-apt-repository ppa:"${PPA_NAME}"
    sudo apt update
    sudo apt install "${PKG_NAME}"
}

function for_mac() {
    use_emacs_plus
}

function use_emacs_plus() {
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@29 --with-dbus --with-native-comp

    M1_BREW_EMACS_PATH="/opt/homebrew/opt/emacs-plus@29/Emacs.app"
    INTEL_BREW_EMACS_PATH="/usr/local/opt/emacs-plus@29/Emacs.app"
    if [[ -d "${M1_BREW_EMACS_PATH}" ]]; then
        ln -sf "${M1_BREW_EMACS_PATH}" /Applications
    else
        ln -sf "${INTEL_BREW_EMACS_PATH}" /Applications
    fi
}

case $(uname) in
    Darwin)
        for_mac
        ;;
    Linux)
        OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
        case ${OS_ID} in
            ubuntu)
                for_ubuntu ubuntu-elisp/ppa emacs-snapshot
                ;;
            manjaro | archlinux)
                for_arch
                ;;
            *)
                echo -n "unsupported os id: ${OS_ID}"
                ;;
        esac
        ;;
    *)
        echo -n "unsuppprted os"
        ;;
esac

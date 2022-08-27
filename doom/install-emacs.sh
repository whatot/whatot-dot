#!/bin/bash
set -eux

function for_arch() {
    sudo pacman -S emacs
}

function for_ubuntu() {
    PPA_NAME=$1
    PKG_NAME=$2

    sudo add-apt-repository ppa:"${PPA_NAME}"
    sudo apt update
    sudo apt install "${PKG_NAME}"
}

function for_mac() {
    brew tap d12frosted/emacs-plus
    brew install emacs-plus@28 --with-native-comp
    ln -s /usr/local/opt/emacs-plus@28/Emacs.app /Applications
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


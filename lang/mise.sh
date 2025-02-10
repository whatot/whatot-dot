#!/bin/bash
set -eux

function for_arch() {
    yay -S mise-bin
}

function for_ubuntu() {
    cargo install cargo-binstall
    cargo binstall mise
}

function brew_install() {
    pkg_name=$1

    if brew ls --versions "$pkg_name" >/dev/null; then
        echo "$pkg_name installed"
    else
        echo "to install $pkg_name"
        brew install "$*"
    fi
}

function for_mac() {
    brew_install mise
}

case $(uname) in
Darwin)
    for_mac
    ;;
Linux)
    OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
    case ${OS_ID} in
    ubuntu)
        for_ubuntu
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

mise use -g java@zulu-17

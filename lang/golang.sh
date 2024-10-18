#!/bin/bash
set -eux

function common_dev_pkgs() {
    go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
    go install github.com/fatih/gomodifytags@latest
    go install github.com/godoctor/godoctor@latest
    go install github.com/haya14busa/gopkgs/cmd/gopkgs@latest
    go install github.com/josharian/impl@latest
    go install github.com/mdempsky/gocode@latest
    go install github.com/rogpeppe/godef@latest
    go install github.com/zmb3/gogetdoc@latest
    go install github.com/x-motemen/gore/cmd/gore@latest
    go install golang.org/x/tools/gopls@latest
    go install github.com/go-delve/delve/cmd/dlv@latest
    go install honnef.co/go/tools/cmd/staticcheck@latest
    go install github.com/cweill/gotests/gotests@latest
    go install github.com/air-verse/air@latest
}

function common_useful_pkgs() {
    go install github.com/Kunde21/markdownfmt/v3/cmd/markdownfmt@latest
    go install github.com/jessfraz/dockfmt@latest
}

function for_arch() {
    sudo pacman -S go go-tools
    yay -S golangci-lint-bin
}

function for_ubuntu() {
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt update
    sudo apt install golang-go

    go install golang.org/x/tools/cmd/guru@latest
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
    # https://github.com/golangci/golangci-lint#install
    # suggest install by binary(brew)
    brew_install golangci-lint

    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
}

export GO111MODULE=on

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

common_dev_pkgs
common_useful_pkgs

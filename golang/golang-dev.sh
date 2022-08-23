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
}

function for_arch() {
    yaourt -S go go-tools golangci-lint-bin
}

function for_ubuntu() {
    if [[ -f "/etc/apt/sources.list.d/longsleep-ubuntu-golang-backports-focal.list" ]]; then
        echo "golang-backports ppa is already installed"
    else
        echo "try to install golang-backports ppa"
        sudo add-apt-repository ppa:longsleep/golang-backports
    fi

    sudo apt update
    sudo apt install golang-go
}

function for_mac() {
    # https://github.com/golangci/golangci-lint#install
    # suggest install by binary(brew)
    brew install golangci-lint

    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest
}

export GO111MODULE=on
OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)

case $(uname) in
    Darwin)
        for_mac
    ;;
    Linux)
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

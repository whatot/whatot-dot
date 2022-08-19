#!/bin/bash
set -eux

function common_pkgs_by_go() {
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

function for_linux() {
    yaourt -S go go-tools golangci-lint-bin

    common_pkgs_by_go
}

function for_mac() {
    # https://github.com/golangci/golangci-lint#install
    # suggest install by binary(brew)
    brew install golangci-lint

    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/gorename@latest
    go install golang.org/x/tools/cmd/guru@latest

    common_pkgs_by_go
}

export GO111MODULE=on

case $(uname) in
    Darwin)
        for_mac
    ;;
    Linux)
        for_linux
    ;;
    *)
    ;;
esac

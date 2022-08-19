#!/bin/bash
set -eux

function common_pkgs_by_go() {
    go get -u -v github.com/cweill/gotests/...
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
    go get -u -v github.com/fatih/gomodifytags
    go get -u -v github.com/godoctor/godoctor
    go get -u -v github.com/haya14busa/gopkgs/cmd/gopkgs
    go get -u -v github.com/josharian/impl
    go get -u -v github.com/mdempsky/gocode
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/zmb3/gogetdoc
    go get -u -v github.com/motemen/gore/cmd/gore

    # don't use -u when install gopls
    rm -f ~/go/bin/gopls
    GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
}

function for_linux() {
    yaourt -S go go-tools golangci-lint-bin

    common_pkgs_by_go
}

function for_mac() {
    # https://github.com/golangci/golangci-lint#install
    # suggest install by binary(brew)
    brew install golangci-lint

    go get -u -v golang.org/x/tools/cmd/goimports
    go get -u -v golang.org/x/tools/cmd/godoc
    go get -u -v golang.org/x/tools/cmd/gorename
    go get -u -v golang.org/x/tools/cmd/guru

    common_pkgs_by_go
}

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

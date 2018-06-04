#!/bin/bash
set -x

# for go
go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v github.com/alecthomas/gometalinter
# gometalinter install all known linters:
gometalinter --install --update

# for rustup
rustup toolchain install nightly
rustup default nightly
rustup component add rls-preview
rustup component add rust-src
rustup component add rustfmt-preview
rustup component add rust-analysis
rustup update
rustc --print sysroot
cargo install clippy

# for emacs in mac
emacs --insecure

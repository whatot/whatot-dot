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

# for haskell, use stack instead of cabal
# the haskell packages are old in system, need be cleaned up by hand
# https://haskell-lang.org/tutorial/stack-build
yaourt -Rsn ghc-mod hlint hasktags hoogle haskell-apply-refact stylish-haskell
stack install apply-refact hlint stylish-haskell hasktags hoogle ghc-mod \
      intero hindent
# hindent: M-x hindent-reformat-buffer

## for rustup
rustup toolchain install nightly
rustup default nightly
rustup component add rls
rustup component add rust-src
rustup component add rust-analysis
rustup update
rustc --print sysroot
cargo install clippy

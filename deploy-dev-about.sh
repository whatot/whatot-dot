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

## for rust
# cargo install rustfmt
# cargo install racer

## for rust in vim
# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Plug 'rust-lang/rust.vim', { 'for': 'rust' }
# Plug 'racer-rust/vim-racer', { 'for': 'rust' }
# let $RUST_SRC_PATH = $HOME . '/git/rust/src/'
# " c-x c-o for complete, gd for definition
# let g:rustfmt_autosave = 1

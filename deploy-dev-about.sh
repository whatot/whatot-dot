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

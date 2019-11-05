#!/bin/bash
set -eux

GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/cweill/gotests/...
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -u -v github.com/fatih/gomodifytags
go get -u -v github.com/godoctor/godoctor
go get -u -v github.com/golangci/golangci-lint/cmd/golangci-lint
go get -u -v github.com/haya14busa/gopkgs/cmd/gopkgs
go get -u -v github.com/josharian/impl
go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/zmb3/gogetdoc


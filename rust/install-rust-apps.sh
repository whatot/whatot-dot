#!/usr/bin/env bash
set -eux

cargo_install() {
    cargo install --force "$@"
}

# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# A command-line tool that converts TOML to JSON. Nothing more, nothing less.
cargo_install toml2json

# Tokei will show the number of files, total lines within those files and code, comments, and blanks grouped by language.
cargo_install tokei

sccache --show-stats

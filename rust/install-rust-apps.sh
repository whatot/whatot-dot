#!/usr/bin/env bash
set -eux

cargo_install() {
    cargo install --force "$@"
}

# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# A command-line tool that converts TOML to JSON. Nothing more, nothing less.
cargo install toml2json

sccache --show-stats

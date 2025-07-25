#!/usr/bin/env bash
set -eux

cargo_install() {
  cargo binstall --only-signed --no-confirm --continue-on-failure --force "$@"
}

if [[ ${GITHUB_TOKEN} ]];then
  echo "GITHUB_TOKEN = ${GITHUB_TOKEN}"
else
  echo "GITHUB_TOKEN ENV IS NOT EXISTS"
  exit 0
fi

# build rust pkg with cache
cargo_install sccache

# Check a local package and all of its dependencies for errors
cargo_install cargo-check

# Display a tree visualization of a dependency graph
cargo_install cargo-tree

# Displays information about project dependency versions
cargo_install cargo-outdated

# Find out what takes most of the space in your executable
cargo_install cargo-bloat
# cargo bloat --release -n 10
# cargo bloat --release --crates
# cargo bloat --release --filter '^__' -n 10

cargo_install cargo-generate
cargo_install cargo-edit
cargo_install bindgen-cli

# A program that list statistics related to usage of unsafe Rust code
# in a Rust crate and all its dependencies.
cargo_install cargo-geiger

# profile anything
cargo_install flamegraph

# Tool to analyse test coverage of cargo projects
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  cargo_install cargo-tarpaulin
else
  echo "skip tarpaulin in ${OSTYPE}"
fi

# Audit Cargo.lock for crates with security vulnerabilities
cargo_install cargo-audit

# Lints your project's crate graph
cargo_install cargo-deny
# cargo deny init
# cargo deny check

# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# A command-line tool that converts TOML to JSON. Nothing more, nothing less.
cargo_install toml2json

# Tokei will show the number of files, total lines within those files and code, comments, and blanks grouped by language.
cargo_install tokei

# Build Rust code for Android
cargo_install cargo-ndk

# background code checker, live-reloading
# https://github.com/Canop/bacon
cargo_install bacon

# cargo fix --edition
sccache --show-stats

#!/bin/env bash
set -eux

cargo_install() {
    cargo install --force "$@"
}

# Check a local package and all of its dependencies for errors
cargo_install cargo-check

# Display a tree visualization of a dependency graph
cargo_install cargo-tree

# Displays information about project dependency versions
cargo_install cargo-outdated

# Find out what takes most of the space in your executable
cargo_install cargo-bloat --features regex-filter
# cargo bloat --release -n 10
# cargo bloat --release --crates
# cargo bloat --release --filter '^__' -n 10

cargo_install cargo-generate --features vendored-openssl
cargo_install cargo-edit
cargo_install bindgen

# A program that list statistics related to usage of unsafe Rust code
# in a Rust crate and all its dependencies.
cargo_install cargo-geiger

# profile anything
cargo_install flamegraph

# cargo fix --edition
sccache --show-stats

# https://hoverbear.org/blog/setting-up-a-rust-devenv/
# https://rust-analyzer.github.io/manual.html
echo "git clone https://github.com/rust-analyzer/rust-analyzer.git && cd rust-analyzer && git pull"
echo "cargo xtask install --server"

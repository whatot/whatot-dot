#!/usr/bin/env bash
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

# cargo fix --edition
sccache --show-stats


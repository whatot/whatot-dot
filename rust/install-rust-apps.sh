#!/bin/env bash
set -eux

function cargo_install() {
    cargo install --force "$@"
}


cargo_install cargo-check
cargo_install cargo-tree
cargo_install cargo-outdated

# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

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

# ydcv-rs in mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    cargo install ydcv-rs --no-default-features --force
    ln -sf ~/.cargo/bin/ydcv-rs ~/.cargo/bin/ydcv
else
    echo "not install ydcv"
fi

# cargo fix --edition
sccache --show-stats

# https://hoverbear.org/blog/setting-up-a-rust-devenv/
# https://rust-analyzer.github.io/manual.html
echo "git clone https://github.com/rust-analyzer/rust-analyzer.git && cd rust-analyzer && git pull"
echo "cargo xtask install --server"

#!/usr/bin/env bash
set -eux

CARGO_CONFIG_FILE="${HOME}/.cargo/config"

cat <<EOF > "${CARGO_CONFIG_FILE}"
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF

rustup toolchain install nightly
rustup default nightly
rustup component add clippy-preview
rustup component add llvm-tools-preview
rustup component add rls-preview
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt-preview
rustup update
rustc --print sysroot
cargo install --force racer

# for tldr to update cache, ``tldr --update``
# cargo install tealdeer

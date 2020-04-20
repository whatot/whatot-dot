#!/usr/bin/env bash
set -eux

# curl https://sh.rustup.rs -sSf | sh

function cargo_install() {
    cargo install --force "$@"
}

if [[ "$OSTYPE" == "msys" ]]; then
    CARGO_CONFIG_PATH="$USERPROFILE/.cargo"
else
    CARGO_CONFIG_PATH="${HOME}/.cargo"
fi

mkdir -p "${CARGO_CONFIG_PATH}"
cat <<EOF > "${CARGO_CONFIG_PATH}/config"
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'tuna'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
EOF

# 特殊指定版本
NEEDED_RUST_VERSION=nightly-2019-12-20
rustup toolchain install "${NEEDED_RUST_VERSION}"
rustup component add rls --toolchain "${NEEDED_RUST_VERSION}"
rustup component add clippy --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-analysis --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-src --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_VERSION}"

# 最新的健康nightly版本
echo
HEALTHY_NIGHTLY_VERSION=nightly-2020-04-10
rustup toolchain install "${HEALTHY_NIGHTLY_VERSION}"
rustup default "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rls
rustup component add clippy
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustc --print sysroot
rustup toolchain list

# cargo_install racer
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

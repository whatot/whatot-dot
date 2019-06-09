#!/usr/bin/env bash
set -eux

# curl https://sh.rustup.rs -sSf | sh

function cargo_install() {
    cargo install --force "$1"
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
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF

# 特殊指定版本
NEEDED_RUST_TOOLCHAIN=nightly-2019-04-25-x86_64-unknown-linux-gnu
rustup component add rls --toolchain "${NEEDED_RUST_TOOLCHAIN}"
rustup component add clippy --toolchain "${NEEDED_RUST_TOOLCHAIN}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_TOOLCHAIN}"

# 最新的健康nightly版本
echo
HEALTHY_NIGHTLY_VERSION=nightly-2019-06-06
rustup toolchain install "${HEALTHY_NIGHTLY_VERSION}"
rustup default "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rls
rustup component add clippy
rustup component add miri
rustup component add llvm-tools-preview
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustc --print sysroot
rustup toolchain list

cargo_install sccache
cargo_install racer
cargo_install cargo-tree
cargo_install cargo-outdated
# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# cargo fix --edition
sccache --show-stats

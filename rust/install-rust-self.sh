#!/usr/bin/env bash
set -eux

# curl https://sh.rustup.rs -sSf | sh

if [[ "${OSTYPE}" == "msys" ]]; then
    CARGO_CONFIG_PATH="${USERPROFILE}/.cargo"
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
NEEDED_RUST_VERSION=nightly-2022-07-30
rustup toolchain install "${NEEDED_RUST_VERSION}"
rustup component add clippy --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-analyzer --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-src --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_VERSION}"
echo

rustup default "${NEEDED_RUST_VERSION}"
rustup run "${NEEDED_RUST_VERSION}" rustc --print sysroot
rustup toolchain list

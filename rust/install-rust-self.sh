#!/usr/bin/env bash
set -eux

# curl https://sh.rustup.rs -sSf | sh

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
NEEDED_RUST_VERSION=nightly-2021-01-25
rustup toolchain install "${NEEDED_RUST_VERSION}"
rustup component add clippy --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-analyzer-preview --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-src --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_VERSION}"
echo

# 最新的健康nightly版本，临时加脚本解决调用问题，下个rustup版本删除
HEALTHY_NIGHTLY_VERSION=nightly-2021-03-07
RUST_ANALYZER_BIN="${HOME}/.cargo/bin/rust-analyzer"
cat <<EOF > "${RUST_ANALYZER_BIN}"
#!/bin/sh
rustup run ${HEALTHY_NIGHTLY_VERSION} rust-analyzer "\$@"
EOF
chmod +x "${RUST_ANALYZER_BIN}"

rustup toolchain install "${HEALTHY_NIGHTLY_VERSION}"
rustup component add clippy --toolchain "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rust-analyzer-preview  --toolchain "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rust-src --toolchain "${HEALTHY_NIGHTLY_VERSION}"
rustup component add rustfmt --toolchain "${HEALTHY_NIGHTLY_VERSION}"

rustup default "${HEALTHY_NIGHTLY_VERSION}"
rustc --print sysroot
rustup toolchain list

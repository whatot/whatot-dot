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

rustup toolchain list
echo
NIGHTLY_VERSION=nightly-2019-04-21
rustup toolchain install "${NIGHTLY_VERSION}"
rustup default "${NIGHTLY_VERSION}"
#rustup update
rustup component add rls
rustup component add clippy
rustup component add miri
rustup component add llvm-tools-preview
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustc --print sysroot

cargo_install sccache
cargo_install racer
cargo_install cargo-tree
cargo_install cargo-outdated
# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# cargo fix --edition
sccache --show-stats

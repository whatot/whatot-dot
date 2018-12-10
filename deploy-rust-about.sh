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
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF

rustup toolchain uninstall nightly
rustup toolchain install beta
rustup default beta
rustup update
rustup component add rls
rustup component add clippy
rustup component add llvm-tools-preview
rustup component add rust-analysis
rustup component add rust-src
rustup component add rustfmt
rustc --print sysroot

cargo install --force cargo-tree
cargo install --force cargo-outdated
# for tldr to update cache, ``tldr --update``
cargo install --force tealdeer

# cargo fix --edition

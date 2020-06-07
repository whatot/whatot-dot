#!/bin/env bash
set -eux

cargo_install() {
    cargo install --force "$@"
}

# for tldr to update cache, ``tldr --update``
cargo_install tealdeer

# ydcv-rs in mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    cargo install ydcv-rs --no-default-features --force
    ln -sf ~/.cargo/bin/ydcv-rs ~/.cargo/bin/ydcv
else
    echo "not install ydcv"
fi

sccache --show-stats

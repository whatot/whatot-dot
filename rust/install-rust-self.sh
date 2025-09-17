#!/usr/bin/env bash
set -eux

# 默认指定版本
NEEDED_RUST_VERSION=nightly-2025-09-16

# 基础目录
CARGO_CONFIG_PATH="${HOME}/.cargo"
LOCAL_RUSTUP_BIN="${CARGO_CONFIG_PATH}/bin/rustup"
mkdir -p "${CARGO_CONFIG_PATH}"

cat <<EOF >"${CARGO_CONFIG_PATH}/config.toml"
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'rsproxy-sparse'
[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
[source.tuna]
registry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"
[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"
[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"
[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"
[net]
git-fetch-with-cli = true
[target.x86_64-unknown-linux-gnu]
rustflags = ["-C", "link-arg=-fuse-ld=mold"]
EOF

# 初始化 rustup
case $(uname) in
  Darwin)
    # 在 macos, brew install rustup-init 后，
    # 执行 rustup-init 初始化后，~/.cargo/bin 中相关bin都是rustup-init的软链
    if [[ -f "${LOCAL_RUSTUP_BIN}" ]]; then
      echo -n "already run rustup-init in macos"
    else
      echo -n "try to run rustup-init in macos"
      rustup-init -y --default-toolchain "${NEEDED_RUST_VERSION}" --no-modify-path
    fi
    # rust-analyzer不在rustup-init软链范围，需要单独处理
    brew install rust-analyzer cargo-binstall
    ;;
  Linux)
    if [[ -f "/usr/bin/pacman" ]]; then
      # arch 与 manjaro 直接系统安装 rustup，不需要执行安装脚本
      echo -n "install rustup by pacman in arch or manjaro"
      sudo pacman -S rustup cargo-binstall
    elif [[ -f "/snap/bin/rustup" ]]; then
      echo -n "already init rustup with snap ubuntu"
    else
      # 不能直接使用系统 rustup 的发行版中，使用远程安装脚本初始化 rustup
      if [[ -f "${LOCAL_RUSTUP_BIN}" ]]; then
        echo -n "already init rustup with curl"
      else
        echo -n "to init rustup with curl"
        curl https://sh.rustup.rs -sSf | sh
      fi
    fi
    ;;
  *)
    echo -n "unsuppprted os"
    ;;
esac

rustup toolchain install "${NEEDED_RUST_VERSION}"
rustup component add clippy --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-analyzer --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rust-src --toolchain "${NEEDED_RUST_VERSION}"
rustup component add rustfmt --toolchain "${NEEDED_RUST_VERSION}"
echo

rustup default "${NEEDED_RUST_VERSION}"
rustup run "${NEEDED_RUST_VERSION}" rustc --print sysroot
rustup toolchain list

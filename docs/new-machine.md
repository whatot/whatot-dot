# New Machine

This runbook is for getting a fresh machine onto the repository. Validation and
smoke tests live in `testing.md`.

## Required Private Env

```shell
cp docs/env_private.example ~/.env_private
```

Fill at least:

```shell
DOTFILES_HOST=macos-arm64
DOTFILES_GIT_NAME="Your Name"
DOTFILES_GIT_EMAIL=you@example.com
```

## macOS

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
scripts/bootstrap
mise trust
mise run setup
```

## Arch Or Manjaro

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
scripts/bootstrap
mise trust
mise run setup
```

Install `paru` or `yay` before `mise run setup` when AUR packages are needed.

## Ubuntu Or Debian

Ubuntu and Debian use separate bootstrap scripts, but the entry flow is the
same:

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
scripts/bootstrap
mise trust
mise run setup
```

## Re-run With A Different Host

```shell
mise run host
DOTFILES_HOST=ubuntu-amd64 mise run setup
DOTFILES_HOST=macos-arm64 mise run setup
```

## Mirror Overrides

Default Linux mirrors use USTC. Override them when a machine needs a different
source:

```shell
DOTFILES_UBUNTU_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/ubuntu scripts/bootstrap
DOTFILES_DEBIAN_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian scripts/bootstrap
DOTFILES_DEBIAN_SECURITY_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian-security scripts/bootstrap
DOTFILES_ARCH_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch,https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' scripts/bootstrap
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' scripts/bootstrap
```

`archlinuxcn` is enabled by default on Arch. Set
`DOTFILES_ENABLE_ARCHLINUXCN=false` when a machine should stay on official Arch
repositories only.

If the `mise.run` installer is slow or unstable on a network, override the
bootstrap fetch settings:

```shell
DOTFILES_MISE_INSTALL_URL=https://mise.run scripts/bootstrap
DOTFILES_MISE_CURL_RETRIES=4 scripts/bootstrap
```

## Optional Development Tools

`mise run setup` already installs host-enabled development tools through
`devtools:host`. Use the extra tasks when you want more language-specific tools
on demand:

```shell
mise run devtools:rust-system
mise run devtools:rust-toolchain
mise run devtools:rust-tools
mise run devtools:rust-tools-extra
mise run devtools:go-tools
```

Rust keeps an existing rustup default when one is already active. Fresh
machines default to `stable`. Prefer project `rust-toolchain.toml` files for
project-specific versions. After `devtools:rust-toolchain`, the script also
prints `rustup toolchain list` plus cleanup hints such as
`rustup toolchain uninstall <toolchain>`.

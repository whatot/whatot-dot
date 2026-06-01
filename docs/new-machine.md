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

Arch bootstrap enables `archlinuxcn` and installs `paru` before
`mise run setup`.

## Debian

Debian uses the Linux bootstrap path:

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
scripts/bootstrap
mise trust
mise run setup
```

## Re-run With A Different Host

```shell
mise run show:host
DOTFILES_HOST=debian-amd64 mise run setup
DOTFILES_HOST=macos-arm64 mise run setup
```

## Mirror Overrides

Default Linux mirrors use USTC. Override them when a machine needs a different
source:

```shell
DOTFILES_DEBIAN_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian scripts/bootstrap
DOTFILES_DEBIAN_SECURITY_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian-security scripts/bootstrap
DOTFILES_ARCH_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch,https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' scripts/bootstrap
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' scripts/bootstrap
```

Arch bootstrap uses `archlinuxcn` for the keyring and `paru`; override
`DOTFILES_ARCHLINUXCN_MIRRORS` when a machine needs a different mirror.

If the `mise.run` installer is slow or unstable on a network, override the
bootstrap fetch settings:

```shell
DOTFILES_MISE_INSTALL_URL=https://mise.run scripts/bootstrap
DOTFILES_MISE_CURL_RETRIES=4 scripts/bootstrap
```

## Optional Development Tools

`mise run setup` already installs the host-enabled development tools. Use the
extra tasks when you want more language-specific tools on demand:

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

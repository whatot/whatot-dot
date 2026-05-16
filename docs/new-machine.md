# New Machine

## macOS

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
mkdir -p ~/.config/dotfiles
cp docs/env_private.example ~/.env_private
scripts/bootstrap
mise trust
mise run setup
```

## Development Tools

After package installation, opt into language-specific CLI tools when needed:

```shell
mise run devtools:rust-system
mise run devtools:rust-toolchain
mise run devtools:rust-tools
mise run devtools:rust-tools-extra
mise run devtools:go-tools
```

Rust setup keeps an existing rustup default when one is already active. New
machines default to `stable`. Prefer project `rust-toolchain.toml` for
project-specific versions; use `DOTFILES_RUST_TOOLCHAIN` or pass a toolchain
name to override the personal default.

`devtools:rust-tools` installs the default Rust CLI set. Heavier or less
portable cargo tools live behind `devtools:rust-tools-extra` so the default
host setup is less likely to fail on one slow package.

`scripts/bootstrap` is the init stage: it installs Homebrew if needed, installs
the minimal init bundle, and applies the chezmoi source tree. `mise run setup`
then installs the active host's `base`, `desktop`, and `dev` package sets.

Use hosts for fuller machine setup:

```shell
DOTFILES_HOST=macos-arm64 mise run setup
```

## Arch Or Manjaro

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
mkdir -p ~/.config/dotfiles
cp docs/env_private.example ~/.config/dotfiles/env
scripts/bootstrap
mise trust
mise run setup
```

Install `paru` or `yay` before running `mise run setup` if AUR packages are
needed.

## Ubuntu Or Debian

Ubuntu and Debian use separate bootstrap scripts. Both apply apt mirrors before
installing base tools:

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
mkdir -p ~/.config/dotfiles
cp docs/env_private.example ~/.config/dotfiles/env
scripts/bootstrap
mise trust
mise run setup
```

Default mirrors use USTC. Override them when needed:

```shell
DOTFILES_UBUNTU_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/ubuntu scripts/bootstrap
DOTFILES_DEBIAN_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian scripts/bootstrap
DOTFILES_DEBIAN_SECURITY_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/debian-security scripts/bootstrap
```

If `mise.run` is slow or unstable on a network, override the installer entry:

```shell
DOTFILES_MISE_INSTALL_URL=https://mise.run scripts/bootstrap
DOTFILES_MISE_CURL_RETRIES=4 scripts/bootstrap
```

Arch mirrors can also be overridden. Use comma-separated values when you want
fallbacks:

```shell
DOTFILES_ARCH_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch,https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch' scripts/bootstrap
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' scripts/bootstrap
```

`archlinuxcn` is enabled by default on Arch. Set
`DOTFILES_ENABLE_ARCHLINUXCN=false` when a machine should use only official Arch
repositories.

## Container Smoke Tests

Use Docker containers for fast Linux bootstrap validation:

```shell
scripts/container-test ubuntu-amd64
scripts/container-test debian-amd64
scripts/container-test arch-amd64
scripts/container-test ubuntu-arm64
scripts/container-test all
```

The container test uses:

```text
ubuntu-amd64   ubuntu:26.04      linux/amd64
debian-amd64   debian:trixie     linux/amd64
arch-amd64     archlinux:latest  linux/amd64
ubuntu-arm64   ubuntu:26.04      linux/arm64
```

This is the fast default for checking package mirrors, bootstrap dependencies,
`chezmoi`, `mise trust`, and `doctor`. Use OrbStack machines only when the
change needs a fuller Linux environment.

Package sets that are safe in containers can be checked with:

```shell
scripts/container-test all packages
```

This runs bootstrap first, then sets `DOTFILES_HOST` to the container target and
installs the package sets declared by that host.

## OrbStack Smoke Tests

Use OrbStack Linux machines to test Linux bootstrap changes before running them
on a real host:

```shell
scripts/orbstack-test ubuntu-amd64
scripts/orbstack-test debian-amd64
scripts/orbstack-test arch-amd64
scripts/orbstack-test ubuntu-arm64
scripts/orbstack-test all
```

The script creates or reuses fixed test machines:

```text
dotfiles-ubuntu-amd64   Ubuntu 26.04 LTS amd64
dotfiles-debian-amd64   Debian 13 amd64
dotfiles-arch-amd64     Arch amd64
dotfiles-ubuntu-arm64   Ubuntu 26.04 LTS arm64
```

OrbStack image names use codenames, so the script requests
`ubuntu:resolute` and `debian:trixie` for those fixed versions.

It pushes the current checkout, then runs `scripts/bootstrap`, `mise trust`,
`scripts/doctor`, and `chezmoi managed --source .`.

Use `--reset` to recreate the target machine:

```shell
scripts/orbstack-test all --reset
```

Local mirror overrides are forwarded into the OrbStack test when set:

```shell
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' scripts/orbstack-test arch-amd64
DOTFILES_ENABLE_ARCHLINUXCN=false scripts/orbstack-test arch-amd64
```

# Testing

This runbook covers validation for bootstrap, package, and environment changes.
Fresh-machine setup lives in `new-machine.md`.

## Test Layers

Use the lightest layer that still exercises the change:

- `mise run check` for local formatting, shell checks, `chezmoi:diff`, and
  workstation preflight
- `scripts/container-test` for fast Linux bootstrap and container-safe package
  checks
- `scripts/orbstack-test` for host-like Linux smoke tests
- real hosts for desktop apps, fonts, input methods, AUR, and other
  machine-bound behavior

The default task shortcuts are:

```shell
mise run test
mise run test:vm
```

## Fixed Linux Targets

Container and OrbStack validation use the same four host targets:

```text
ubuntu-amd64
debian-amd64
arch-amd64
ubuntu-arm64
```

Container images:

```text
ubuntu-amd64   ubuntu:26.04      linux/amd64
debian-amd64   debian:trixie     linux/amd64
arch-amd64     archlinux:latest  linux/amd64
ubuntu-arm64   ubuntu:26.04      linux/arm64
```

OrbStack machines:

```text
dotfiles-ubuntu-amd64   Ubuntu 26.04 LTS amd64
dotfiles-debian-amd64   Debian 13 amd64
dotfiles-arch-amd64     Arch amd64
dotfiles-ubuntu-arm64   Ubuntu 26.04 LTS arm64
```

## Container Smoke Tests

Use containers as the fast default for Linux validation:

```shell
scripts/container-test ubuntu-amd64
scripts/container-test debian-amd64
scripts/container-test arch-amd64
scripts/container-test ubuntu-arm64
scripts/container-test all
```

The bootstrap stage verifies mirrors, minimum dependencies, `chezmoi`,
`mise trust`, and `scripts/doctor`.

For container-safe package inventories:

```shell
scripts/container-test all packages
```

This runs bootstrap first, then installs the package sets declared by the fixed
container hosts. Desktop, font, input-method, and AUR checks do not belong in
containers.

## OrbStack Smoke Tests

Use OrbStack when a Linux change needs a fuller machine-like environment:

```shell
scripts/orbstack-test ubuntu-amd64
scripts/orbstack-test debian-amd64
scripts/orbstack-test arch-amd64
scripts/orbstack-test ubuntu-arm64
scripts/orbstack-test all
```

The script creates or reuses fixed machines, syncs the current checkout, then
runs:

```text
scripts/bootstrap
mise trust
scripts/doctor
chezmoi managed --source .
```

Reset a machine when you want a clean rebuild:

```shell
scripts/orbstack-test all --reset
```

## Mirrors And Proxy Forwarding

Both Linux test scripts forward the relevant bootstrap overrides into the test
environment when they are set locally. That includes mirror variables, retry
settings, `DOTFILES_MISE_INSTALL_URL`, `DOTFILES_MISE_CURL_RETRIES`, and proxy
variables.

For example:

```shell
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' scripts/orbstack-test arch-amd64
DOTFILES_ENABLE_ARCHLINUXCN=false scripts/container-test arch-amd64
```

## Real Host Checks

Use a real machine when the change touches:

- Homebrew casks or macOS app installs
- desktop apps, fonts, or input methods
- AUR-only packages
- terminal themes, shell interaction, or editor UX
- anything that depends on a real login session or system integration

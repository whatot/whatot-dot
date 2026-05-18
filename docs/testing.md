# Testing

This runbook covers validation for bootstrap, package, and environment changes.
Fresh-machine setup lives in `new-machine.md`.

## Test Layers

Use the lightest layer that still exercises the change:

- `mise run check` for local formatting, shell checks, `chezmoi:diff`, and
  workstation diagnostics
- `tests/smoke/container.sh` for fast Linux bootstrap and container-safe package
  checks
- `tests/smoke/macos.sh host` for macOS Brewfile checks on a real host
- `tests/smoke/orbstack.sh` for host-like Linux smoke tests
- real hosts for desktop apps, fonts, input methods, AUR, and other
  machine-bound behavior

## Zsh Validation

Zsh files use zsh-specific syntax such as `path` arrays and `${(@)...}`
expansions, so this repository does not force them through `shfmt`.

Use the current checks instead:

- `zsh -n` on rendered `zshenv`, `zprofile`, `zshrc`, and each rendered module
- rendered-shell smoke via `tests/checks/rendered.sh`
- `shellcheck` and `shfmt` only for the bash/sh-oriented scripts under
  `scripts/`, `bootstrap/`, and `tests/`

Practical rule:

- if a file is intended for zsh runtime config, prefer `zsh -n` plus rendered
  execution checks
- if a file is intended as a standalone shell script, keep it compatible with
  `shellcheck` and `shfmt`

## Template Validation

Template behavior belongs under `tests/tmpl/`, with `tests/tmpl/run` as the
single entrypoint used by `tests/check`.

Use template tests for cases such as:

- rendering with and without required environment variables
- normalization rules such as trailing-slash handling
- malformed optional input that should be ignored instead of producing broken
  config

Private env parsing is validated through `tests/checks/helpers.sh`. Invalid
lines in `~/.env_private` or `~/.dotfiles.env` should fail fast with a file and
line number instead of being ignored silently.

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
tests/smoke/container.sh ubuntu-amd64
tests/smoke/container.sh debian-amd64
tests/smoke/container.sh arch-amd64
tests/smoke/container.sh ubuntu-arm64
tests/smoke/container.sh all
```

The bootstrap stage verifies mirrors, minimum dependencies, `chezmoi`,
`mise trust`, and `scripts/doctor`.

For container-safe package inventories:

```shell
tests/smoke/container.sh all packages
```

This runs bootstrap first, then installs the package sets declared by the fixed
container hosts. Desktop, font, input-method, and AUR checks do not belong in
containers.

For host-enabled Linux devtools:

```shell
tests/smoke/container.sh all devtools
```

This also runs bootstrap first, then executes `scripts/devtools host` for the
declared container hosts. The current Linux hosts keep this to the minimal
`rust-system` layer so the validation stays container-safe.

## OrbStack Smoke Tests

Use OrbStack when a Linux change needs a fuller machine-like environment:

```shell
tests/smoke/orbstack.sh ubuntu-amd64
tests/smoke/orbstack.sh debian-amd64
tests/smoke/orbstack.sh arch-amd64
tests/smoke/orbstack.sh ubuntu-arm64
tests/smoke/orbstack.sh all
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
tests/smoke/orbstack.sh all --reset
```

## Mirrors And Proxy Forwarding

Both Linux test scripts forward the relevant bootstrap overrides into the test
environment when they are set locally. That includes mirror variables, retry
settings, `DOTFILES_MISE_INSTALL_URL`, `DOTFILES_MISE_CURL_RETRIES`, and proxy
variables.

For localhost-style proxies, `tests/smoke/container.sh` rewrites
`127.0.0.1` and `localhost` to `host.docker.internal` for Docker reachability.
`tests/smoke/orbstack.sh` forwards proxy values as-is, so they should already be
reachable from the VM.

For example:

```shell
DOTFILES_ARCHLINUXCN_MIRRORS='https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch,https://mirrors.ustc.edu.cn/archlinuxcn/$arch' tests/smoke/orbstack.sh arch-amd64
DOTFILES_ENABLE_ARCHLINUXCN=false tests/smoke/container.sh arch-amd64
```

## macOS Package Checks

Use the current macOS host when the change touches Homebrew package inventories:

```shell
tests/smoke/macos.sh host
```

This runs `brew bundle check --no-upgrade` for the package sets declared by
`hosts/macos-arm64.toml`.

## Real Host Checks

Use a real machine when the change touches:

- macOS Homebrew inventories, including the `plantuml` plus `openjdk` pair
- Homebrew casks or macOS app installs
- desktop apps, fonts, or input methods
- AUR-only packages
- terminal themes, shell interaction, or editor UX
- anything that depends on a real login session or system integration

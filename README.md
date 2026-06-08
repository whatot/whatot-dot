# Dotfiles

Workstation bootstrap and dotfiles for macOS and Linux, centered on `chezmoi`,
`mise`, host-selected package inventories, and a small script runtime.

## Quick Start

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
cp docs/env_private.example ~/.env_private
scripts/bootstrap
mise trust
mise run setup
```

The private env must define:

```shell
DOTFILES_HOST=macos-arm64
DOTFILES_GIT_NAME="Your Name"
DOTFILES_GIT_EMAIL=you@example.com
```

Built-in hosts:

- `macos-arm64`
- `debian-amd64`
- `arch-amd64`

## Daily Use

```shell
mise run show
mise run show:cheat
mise run show:host
mise run show:dotfiles
mise run doctor
mise run outdated
mise run outdated:mise
mise run chezmoi:apply
mise run check
mise run update
mise run update:packages
```

Validation commands live in [docs/testing.md](docs/testing.md).

## Common Tools

Common daily CLI tools are installed through OS package inventories on the
primary macOS and Arch hosts. `mise` keeps selected language runtimes and tools
that need consistent cross-repo versions:

- `rtk`: token-aware shell proxy for AI-assisted terminal work. Source: [rtk-ai/rtk](https://github.com/rtk-ai/rtk)

## Repository Layout

- `home/`: dotfiles and generated user config managed by `chezmoi`
- `bootstrap/`: first-run machine preparation
- `packages/`: coarse OS package inventories
- `hosts/`: per-machine execution plans
- `scripts/`: stable command entrypoints used by `mise`
- `docs/`: runbooks and design notes

## Docs

- `docs/architecture.md`: design choices, boundaries, and where new changes go
- `docs/cheat.md`: short shell and dotfiles command cheat sheet
- `docs/new-machine.md`: fresh-machine setup and mirror overrides
- `docs/testing.md`: container, OrbStack, and real-host validation
- `docs/vim-regex.md`: Vim regex notes

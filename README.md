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
- `ubuntu-amd64`
- `debian-amd64`
- `arch-amd64`
- `ubuntu-arm64`

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

These workstation-global CLI tools are installed through `mise`:

- `rtk`: token-aware shell proxy for AI-assisted terminal work. Source: [rtk-ai/rtk](https://github.com/rtk-ai/rtk)
- `rg`: fast text search. Source: [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- `fd`: friendly file and directory search. Source: [sharkdp/fd](https://github.com/sharkdp/fd)
- `fzf`: fuzzy picker for files, history, and command output. Source: [junegunn/fzf](https://github.com/junegunn/fzf)
- `bat`: syntax-highlighted file viewer. Source: [sharkdp/bat](https://github.com/sharkdp/bat)
- `btm`: terminal system monitor. Source: [ClementTsang/bottom](https://github.com/ClementTsang/bottom)
- `zoxide`: smarter directory jumping via `z` and `zi`. Source: [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)
- `jj`: Git-compatible change-oriented VCS. Source: [jj-vcs/jj](https://github.com/jj-vcs/jj)

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

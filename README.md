# Dotfiles

Personal workstation bootstrap and dotfiles for macOS and Linux.

The repository is organized around a small toolchain:

- `chezmoi` manages dotfiles from `home/`.
- `mise` is the daily command entrypoint and development tool manager.
- Host-selected package sets manage macOS and Linux packages.
- `pacman`/AUR package lists manage Arch packages.

## Layout

```text
.
├── .chezmoiroot
├── mise.toml
├── scripts/
├── bootstrap/
├── home/
├── packages/
├── hosts/
└── docs/
```

## First Run

```shell
git clone <repo> ~/git/dotfiles
cd ~/git/dotfiles
scripts/bootstrap
mise trust
mise run setup
```

After the first run, use `mise` for day-to-day operations:

```shell
mise run status
mise run chezmoi:diff
mise run chezmoi:apply
mise run refresh
mise run check
mise run update
mise run test
```

Linux bootstrap applies package mirrors first. Defaults use USTC and can be
overridden with `DOTFILES_UBUNTU_MIRROR`, `DOTFILES_DEBIAN_MIRROR`,
`DOTFILES_DEBIAN_SECURITY_MIRROR`, `DOTFILES_ARCH_MIRRORS`, or
`DOTFILES_ARCHLINUXCN_MIRRORS`. Arch enables `archlinuxcn` by default; set
`DOTFILES_ENABLE_ARCHLINUXCN=false` to skip it.

Rust project versions should normally be set by each project with
`rust-toolchain.toml`. The macOS host ensures rustup has an active default
toolchain before cargo-managed tools are installed; new machines default to
`stable`.

Most cross-platform development CLI tools are installed by `mise install`.
System packages stay in `packages/`.

Git hooks are managed by `pre-commit` through `mise`. Formatting and lint tools
are invoked with `mise exec` so their versions come from `mise.toml`:

```shell
mise run check
```

During larger refactors, `mise run check` also scans `scripts/` and
`bootstrap/` directly so new files are checked before they are staged.

## Hosts

The active host is selected with `DOTFILES_HOST`. Override it per command:

```shell
mise run host
DOTFILES_HOST=ubuntu-amd64 mise run setup
DOTFILES_HOST=macos-arm64 mise run setup
```

Or keep a local default outside git:

```shell
mkdir -p ~/.config/dotfiles
cp docs/env_private.example ~/.config/dotfiles/env
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

Specialized development tool and utility commands are documented in `docs/`.

## Editors And Terminal

- Zed is the default GUI editor.
- Vim is the default terminal editor and is managed by chezmoi.
- Ghostty is the default terminal.
- aqua is kept as a reserve inventory for future precisely pinned CLI tools.

Vim has two profiles:

- `minimal`: no plugins, always available.
- `tiny`: lightweight plugin-based setup.

The active Vim profile is selected through chezmoi data:

```toml
[vim]
profile = "tiny"
```

## Where Things Go

- Dotfiles and generated user config go in `home/`.
- Package inventories go in `packages/` and are selected by hosts. Keep package
  sets coarse: `base`, `desktop`, and `dev`.
- New-machine init goes in `bootstrap/`; long-term package baselines go in
  `packages/*/base.*`.
- Reusable commands go in `scripts/` and are registered in `mise.toml`.
- Host selections go in `hosts/`.

## Shell

Zsh is configured directly by chezmoi. The repository `mise.toml` is expected
to be trusted with `mise trust`.

The shell loads modern tools when they are available:

- `mise`
- `zoxide`
- `direnv`
- `fzf`
- zsh autosuggestions and syntax highlighting

Integrations that are not installed on a host are skipped.

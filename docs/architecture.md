# Architecture

This is a workstation configuration repository, not a general-purpose
configuration management system.

## Responsibilities

```text
home/       dotfiles rendered by chezmoi
packages/   software inventories
bootstrap/  minimum new-machine setup
hosts/      host execution plans
scripts/     stable command entrypoints
mise.toml   daily task registry
```

## Tool Choices

The main path is intentionally small:

- `chezmoi` for dotfiles, templates, and per-host data.
- `mise` for tasks, development runtimes, and cross-platform CLI tools.
- coarse package set files for OS packages.
- `pacman` plus an AUR helper for Arch packages.
- small shell scripts for bootstrap, package install, and tool setup.

The following tools are intentionally removed from the main path:

- Ansible
- Nix, Home Manager, nix-darwin
- WezTerm
- Doom Emacs
- Nvim
- Zim

## Configuration Flow

New machines enter through `scripts/bootstrap`.

Daily changes should follow this flow:

```shell
mise run status
mise run chezmoi:diff
mise run chezmoi:apply
mise run refresh
mise run check
git diff
```

Host selections go into `hosts/`. Package inventories go into `packages/`.
Dotfile changes go into `home/` and are previewed/applied through
`chezmoi:diff` and `chezmoi:apply`. First-run OS setup goes into `bootstrap/`.
The bootstrap stage installs only enough software to make the repository usable;
the `base` package set is the long-term baseline managed by the active host. The
active host is selected locally or per command:

```shell
mise run host
DOTFILES_HOST=ubuntu-amd64 mise run setup
DOTFILES_HOST=macos-arm64 mise run setup
```

Local defaults can live outside git in:

```text
~/.config/dotfiles/env
~/.dotfiles.env
~/.env_private
```

`scripts/lib/env` only loads these private env files. Host execution plan
parsing lives in `scripts/lib/plan` and reads the git-managed `hosts/*.toml`
files.

`scripts/preflight` runs before user-facing lifecycle tasks and before
bootstrap applies chezmoi. It requires `DOTFILES_HOST`, `DOTFILES_GIT_NAME`, and
`DOTFILES_GIT_EMAIL` so host selection and generated Git identity never fall
back to silent defaults.

Linux bootstrap changes should be smoke-tested in OrbStack machines before they
are trusted on a real host:

```shell
scripts/container-test ubuntu-amd64
scripts/container-test debian-amd64
scripts/container-test arch-amd64
scripts/container-test ubuntu-arm64
scripts/container-test all
```

Containers are the fast path for bootstrap, mirror, chezmoi, mise, and doctor
checks. OrbStack machines are the slower path for host-like behavior:

```shell
scripts/container-test all packages
```

The package stage installs only the package sets declared by the fixed
container hosts. Desktop, font, input-method, and AUR checks belong to OrbStack
machines or real hosts.

```shell
scripts/orbstack-test ubuntu-amd64
scripts/orbstack-test debian-amd64
scripts/orbstack-test arch-amd64
scripts/orbstack-test ubuntu-arm64
scripts/orbstack-test all
```

Package sets should stay coarse:

```text
base       terminal-safe baseline packages
desktop    GUI apps, fonts, and input methods
dev        OS-level development dependencies and heavier local services
```

Tools should default to `mise.toml` when they are language runtimes or portable
developer CLIs. Keep GUI apps, fonts, shell plugins, compilers, native build
dependencies, and OS integration packages in `packages/`.

Tools that are not available on every supported platform should stay outside
the global `[tools]` set until a host explicitly needs them.

Local quality gates use `pre-commit`, installed by mise. `mise run check` also
runs a repository-level script check so newly added, not-yet-tracked shell files
are covered during refactors. `shellcheck`, `shfmt`, and `dprint` are managed by
mise and invoked through `mise exec`.

## Mirrors

Bootstrap applies package mirrors before installing base tools on Linux:

```text
bootstrap/ubuntu.sh   Ubuntu apt sources
bootstrap/debian.sh   Debian apt sources
bootstrap/arch.sh     Arch pacman mirrorlist
```

Default mirrors use USTC. They can be overridden with:

```text
DOTFILES_UBUNTU_MIRROR
DOTFILES_DEBIAN_MIRROR
DOTFILES_DEBIAN_SECURITY_MIRROR
DOTFILES_ARCH_MIRRORS
DOTFILES_ARCH_MIRROR
DOTFILES_ARCHLINUXCN_MIRRORS
DOTFILES_ARCHLINUXCN_MIRROR
DOTFILES_ENABLE_ARCHLINUXCN
DOTFILES_MISE_INSTALL_URL
DOTFILES_MISE_CURL_RETRIES
```

## Development Tools

Language tool setup is represented as inventory plus commands:

```text
packages/go/tools.txt
packages/rust/system-*.txt
packages/rust/tools.txt
packages/rust/tools-extra.txt
scripts/devtools
```

Language-specific setup is exposed through:

```shell
mise run setup
mise run devtools:rust-system
mise run devtools:rust-toolchain
mise run devtools:rust-tools
mise run devtools:rust-tools-extra
mise run devtools:go-tools
```

Rust project versions should normally be selected by each project through
`rust-toolchain.toml`. Workstation hosts ensure rustup has an active default
toolchain before cargo-managed tools; new machines default to `stable`. Use
`DOTFILES_RUST_TOOLCHAIN` or pass a toolchain name to override that default.

Cargo configuration is a normal chezmoi-managed dotfile at
`home/dot_cargo/config.toml`.

The default Rust tools list should stay fast and broadly portable. Heavier cargo
tools that often depend on platform-specific binaries or slower fallback builds
belong in `packages/rust/tools-extra.txt`.

C/C++ setup is not a default path, but Rust keeps its own small system
dependency lists for linkers, pkg-config based crates, and build scripts.

## Shell

Zsh is configured as a direct chezmoi-managed file at `home/dot_zshrc.tmpl`.
There is no `.zimrc` and no shell framework bootstrap. Interactive features come
from standalone tools and distro/Homebrew packages:

- `mise activate zsh`, with the repository trusted via `mise trust`
- `zoxide init zsh`
- `direnv hook zsh`
- `fzf --zsh`
- zsh autosuggestions and syntax highlighting

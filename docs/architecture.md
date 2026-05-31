# Architecture

This repository manages one workstation at a time. It is not trying to become
general-purpose configuration management.

## Main Path

The default path stays intentionally small:

- `chezmoi` manages dotfiles and rendered templates from `home/`
- `mise` manages daily tasks, portable CLIs, and language runtimes
- `hosts/*.toml` select which package groups and setup steps apply to a machine
- `bootstrap/` installs only enough software to make the repository usable
- `packages/` define the long-term OS package inventory

## Responsibilities

```text
home/       dotfiles and generated user config
packages/   coarse OS package inventories
bootstrap/  first-run system preparation
hosts/      per-machine execution plans
scripts/    stable command entrypoints
mise.toml   daily task registry
docs/       runbooks and design notes
tests/      validation entrypoints and test implementations
```

## Configuration Model

1. Private env outside git selects the active host and Git identity.
2. `scripts/preflight` is the internal hard prerequisite check. It validates
   required private settings such as `DOTFILES_HOST`, `DOTFILES_GIT_NAME`, and
   `DOTFILES_GIT_EMAIL`, and is used directly by low-level scripts such as
   `bootstrap` and `chezmoi`.
3. `hosts/*.toml` decide which package groups and optional setup behavior apply
   to a machine.
4. `bootstrap/` installs the minimum prerequisites, applies Linux mirrors, and
   makes `chezmoi` plus `mise` usable.
5. `packages/` provide the long-term OS-level inventory.
6. `home/` provides dotfiles rendered by `chezmoi`.
7. `scripts/doctor` is the user-facing readiness report. It builds on
   `preflight`, checks command availability, and can add host-plan-aware
   diagnostics before setup or update flows.
8. `scripts/` plus `mise.toml` expose stable workstation entrypoints such as
   `setup`, `show`, `update`, and focused subcommands.
9. `tests/` owns repository validation entrypoints and test implementations.

Local private defaults live in:

```text
~/.env_private
~/.dotfiles.env
```

## Placement Rules

- Put first-run prerequisites and distro mirror changes in `bootstrap/`.
- Put OS packages, GUI apps, fonts, compilers, native build dependencies,
  common daily CLIs, and shell plugins in `packages/`.
- Put language runtimes and developer tools that need consistent cross-repo
  versions in `mise.toml`.
- Put machine-specific combinations in `hosts/`, not ad hoc conditionals across
  unrelated scripts.
- Put user config and templated dotfiles in `home/`.
- Keep secrets and machine-local values in `~/.env_private` or
  `~/.dotfiles.env`, never in git-managed files.

Package groups stay coarse:

```text
base      terminal-safe baseline packages
desktop   GUI apps, fonts, and input methods
dev       OS-level development dependencies and heavier local services
```

## Tool Choices

The main path intentionally avoids heavier framework stacks. These are removed
from the default path:

- Ansible
- Nix, Home Manager, nix-darwin
- WezTerm
- Doom Emacs
- Nvim
- Zim

## Development Tools

macOS and Arch are the primary daily hosts. Common CLI tools that are readily
available from Homebrew or pacman should default to OS packages on those hosts
so shell completions and PATH behavior stay simple.

Debian stays the minimal non-desktop apt target for containers, servers, smoke
tests, and temporary development environments. Do not mirror the full daily
desktop toolset there unless it becomes a primary daily machine.

Language runtimes should default to `mise`. Developer tools that need consistent
cross-repo versions can also stay in `mise`; OS-level build dependencies and
common CLIs stay in `packages/`.

Rust versions should normally come from each project's `rust-toolchain.toml`.
This repository only ensures `rustup` exists, has a usable default toolchain,
and can install the workstation CLI set.

Heavier or less portable cargo tools should stay in separate inventories or
tasks instead of slowing the default setup path for every machine.

## Defaults

- Ghostty is the default terminal.
- Zed is the default GUI editor.
- Vim is the default terminal editor, with `minimal` and `tiny` profiles.
- Fish is the primary interactive shell.
- Zsh stays as a small fallback shell for systems and tools that still launch
  it.

## Zsh Startup

The zsh startup files share one POSIX profile and keep interactive fallback
behavior narrow:

- `home/dot_config/dotfiles/profile.sh` owns base environment variables, private
  env loading, and the preferred PATH order.
- `home/dot_profile` is the POSIX login-shell wrapper for bash/sh-style shells.
- `home/dot_zshenv` sources the shared profile for zsh-launched tools.
- `home/dot_zprofile` handles login-shell follow-up needed after macOS
  `/etc/zprofile` runs `path_helper`.
- `home/dot_zshrc` owns only the small interactive fallback: history,
  proxy helpers, `mise --shims`, and a few aliases.

## Validation

Local quality gates run through `mise run check`, `tests/check`, and `prek`
using the repo's pre-commit-compatible hook config. Environment validation is
split by layer:

- containers for fast Linux bootstrap and container-safe package checks
- OrbStack machines for host-like Linux validation
- real hosts for desktop apps, fonts, input methods, AUR, and other
  machine-bound behavior

See `testing.md` for the concrete commands and test matrix.

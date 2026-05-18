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
- Put OS packages, GUI apps, fonts, compilers, native build dependencies, and
  shell plugins in `packages/`.
- Put portable developer CLIs and language runtimes in `mise.toml` when they
  work well cross-platform.
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

Language runtimes and portable CLIs should default to `mise`. OS-level build
dependencies stay in `packages/`.

Rust versions should normally come from each project's `rust-toolchain.toml`.
This repository only ensures `rustup` exists, has a usable default toolchain,
and can install the workstation CLI set.

Heavier or less portable cargo tools should stay in separate inventories or
tasks instead of slowing the default setup path for every machine.

## Defaults

- Ghostty is the default terminal.
- Zed is the default GUI editor.
- Vim is the default terminal editor, with `minimal` and `tiny` profiles.
- Zsh is configured directly by `chezmoi`, without a shell framework.

## Zsh Startup

The zsh startup files have distinct responsibilities and should stay that way:

- `home/dot_zshenv.tmpl` owns base environment variables and the preferred PATH
  order.
- `home/dot_zprofile.tmpl` handles login-shell follow-up needed after macOS
  `/etc/zprofile` runs `path_helper`, and only keeps narrow login-time
  integration such as OrbStack path and completions.
- `home/dot_zshrc.tmpl` owns interactive shell behavior only: options,
  completion, aliases, hooks, and prompt setup.
- `home/dot_zsh/*.zsh.tmpl` hold focused interactive modules loaded by
  `dot_zshrc`.

`mise` runs in `--shims` mode from `dot_zsh/tools.zsh.tmpl` so the shell PATH
stays short and stable instead of expanding every tool install directory.

## Validation

Local quality gates run through `mise run check`, `tests/check`, and
`pre-commit`. Environment validation is split by layer:

- containers for fast Linux bootstrap and container-safe package checks
- OrbStack machines for host-like Linux validation
- real hosts for desktop apps, fonts, input methods, AUR, and other
  machine-bound behavior

See `testing.md` for the concrete commands and test matrix.

# AGENTS

## Read First

- `docs/architecture.md`: repository shape, placement rules, and the default workstation path
- `docs/new-machine.md`: bootstrap and setup flow for real machines
- `docs/testing.md`: validation matrix and concrete test commands

## Core Rules

- Keep the main path small. This repo manages one workstation at a time through `chezmoi`, `mise`, `hosts/*.toml`, `bootstrap/`, and `packages/`.
- Do not reintroduce heavier default stacks such as Ansible, Nix, Home Manager, nix-darwin, WezTerm, Doom Emacs, or Nvim unless the user explicitly asks.
- Prefer stable script entrypoints in `scripts/` over ad hoc one-off command flows.
- Put OS package inventory in `packages/`, machine-specific combinations in `hosts/`, first-run system preparation in `bootstrap/`, and rendered user config in `home/`.
- Keep secrets and machine-local values out of git. Use `~/.env_private` or `~/.dotfiles.env`.

## Change Rules

- Keep package groups coarse: `base`, `desktop`, and `dev`.
- Keep host behavior driven by `hosts/*.toml`, not scattered conditionals across unrelated scripts.
- Put portable CLIs and language runtimes in `mise.toml` only when they are part of the normal workstation path.
- Standardize managed app config content under XDG-style paths such as `~/.config/<tool>/...`.
- On macOS, when a tool expects `~/Library/Application Support/<tool>/...`, keep that native path as a symlink back to the XDG-managed file instead of maintaining two copies.
- When managing those macOS compatibility symlinks through chezmoi, avoid changing `~/Library` or `~/Library/Application Support` directory metadata; only manage the leaf app path.
- Do not grow `mise.toml` with low-value test shortcuts. Prefer documenting validation commands in `docs/testing.md`.
- Keep validation scripts non-interactive and compatible with the older Bash version that ships with macOS.
- On macOS, `plantuml` must stay paired with an explicit Java formula such as `openjdk`.

## Validation Rules

- Run `mise run check` for local formatting and rendered-dotfile validation.
- Use `tests/smoke/container.sh` for Linux bootstrap and container-safe package or devtool checks.
- Use `tests/smoke/orbstack.sh` when a Linux change needs a fuller machine-like environment.
- Use `tests/smoke/macos.sh host` for macOS Brewfile validation.
- Do not treat `homebrew/brew` on Linux as a real macOS environment.
- Use a real host for desktop apps, fonts, input methods, AUR, and macOS system integration checks.

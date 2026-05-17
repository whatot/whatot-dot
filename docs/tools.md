# Tools

This note is a short usage guide for the everyday CLI tools installed through
this workstation setup.

## `rg`

Use `rg` for text search by default.

```shell
rg keyword
rg -n "TODO|FIXME" src
rg -tmd pattern docs
rg -g '*.ts' useEffect
```

Prefer `rg --files` when you only need file paths:

```shell
rg --files
rg --files | rg 'prompt|zsh'
```

## `fd`

Use `fd` for file and directory discovery when path matching is easier than
full-text search.

```shell
fd prompt
fd '\.toml$' hosts
fd -t d vendor
```

## `fzf`

Use `fzf` as the interactive selector on top of `rg`, `fd`, history, or other
command output.

```shell
rg --files | fzf
fd . docs | fzf
history 1 | fzf
```

## `bat`

Use `bat` when you want syntax-highlighted file previews.

```shell
bat mise.toml
bat --style=plain docs/tools.md
```

The shell alias `cat` maps to `bat` when `bat` is installed.

## `zoxide`

Use `zoxide` for frequent directory jumps.

```shell
z repo
z dotfiles
zi
```

`z` jumps to the best match. `zi` opens the interactive picker.

## `jj`

Use `jj` when you want a change-oriented workflow on top of Git repositories.

Common commands:

```shell
jj st
jj log
jj diff
jj new
jj describe
jj squash
jj git push
```

Use `jj st` for the current state, `jj log` for the change graph, and
`jj git push` when you are ready to send Git refs upstream.

## `rtk`

Use `rtk` as the local Research Task Kit CLI. It is installed through `mise`.

Typical flow:

```shell
rtk --help
rtk doctor
rtk auth login
```

Repository-local agent guidance usually lives in `RTK.md` when a project wants
RTK-specific instructions, similar to how some repositories keep `AGENTS.md`.

## `mise`

Use `mise` for tool installation and task execution.

```shell
mise install
mise ls
mise run check
mise run setup
```

The shell alias `m` maps to `mise run`.

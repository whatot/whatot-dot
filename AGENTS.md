# AGENTS

本文件是仓库地图，不是完整手册。细节放在 `docs/`、稳定入口放在
`scripts/`，可复用任务行为放在 Codex skills。保持短小，避免把一次性经验堆进这里。

## 地图

- `docs/architecture.md`：仓库形状、放置规则和默认 workstation 路径
- `docs/new-machine.md`：真实机器 bootstrap 和 setup 流程
- `docs/testing.md`：验证矩阵和具体测试命令
- `docs/codex-skills.md`：Codex skill 管理索引、参考来源和校验说明
- `docs/cheat.md`：常用命令速查

## 工作范围

- 保持主路径小而清晰。这个仓库通过 `chezmoi`、`mise`、`hosts/*.toml`、`bootstrap/` 和 `packages/` 管理单台 workstation。
- 除非用户明确要求，不要重新引入 Ansible、Nix、Home Manager、nix-darwin、WezTerm、Doom Emacs 或 Nvim 这类更重的默认栈。
- 优先使用 `scripts/` 中稳定的脚本入口，不要把一次性命令流扩散到文档或配置里。
- OS 包清单放在 `packages/`，机器组合放在 `hosts/`，首次系统准备放在 `bootstrap/`，渲染后的用户配置放在 `home/`。
- 不要把 secret 和机器本地值提交到 git；使用 `~/.env_private` 或 `~/.dotfiles.env`。

## 变更规则

- 包分组保持粗粒度：`base`、`desktop`、`dev`。
- host 行为由 `hosts/*.toml` 驱动，不要把条件判断散落到无关脚本里。
- 常用 CLI 优先放进 macOS/Arch 的 OS package 清单；语言运行时和需要跨仓库一致版本的工具才放进 `mise.toml`。
- 不要在受管理文件或测试中硬编码机器本地绝对路径，例如特定 home 目录；从模板数据、`$HOME` 或仓库 helper 推导。
- 受管理的 app 配置优先放在 XDG 风格路径，例如 `~/.config/<tool>/...`。
- 在 macOS 上，如果工具要求 `~/Library/Application Support/<tool>/...`，用 symlink 指回 XDG 管理文件，不维护两份配置。
- 通过 chezmoi 管理这些 macOS 兼容 symlink 时，不要修改 `~/Library` 或 `~/Library/Application Support` 目录元数据，只管理叶子 app 路径。
- Codex skill 源文件只放在 `home/dot_codex/skills/`；外部仓库只作为参考来源，吸收前先按本地工作流重写。
- 不要用低价值测试快捷方式膨胀 `mise.toml`；验证命令优先记录在 `docs/testing.md`。
- 验证脚本保持非交互，并兼容 macOS 自带的旧 Bash。
- 在 macOS 上，`plantuml` 必须和明确的 Java formula 搭配，例如 `openjdk`。

## 验证规则

- 运行 `mise run check` 做本地格式化和 rendered dotfile 校验。
- Linux bootstrap、container-safe package 或 devtool 检查使用 `tests/smoke/container.sh`。
- 当 Linux 变更需要更接近真实机器的环境时，使用 `tests/smoke/orbstack.sh`。
- macOS Brewfile 校验使用 `tests/smoke/macos.sh host`。
- 不要把 Linux 上的 `homebrew/brew` 当成真实 macOS 环境。
- desktop app、字体、输入法、AUR 和 macOS 系统集成检查需要使用真实 host。

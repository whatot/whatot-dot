# OpenSpec 与全局 Codex Skills

OpenSpec 接替 `charter-run` 的持久化规划流程。CLI 和官方 skills 全局安装，
各项目按需启用，只在仓库内保存自己的规格、设计和任务。

## 安装

macOS 使用 `packages/macos/dev.Brewfile` 中的官方 Homebrew formula：

```bash
brew install openspec
```

Arch 使用 `packages/arch/aur.txt` 中的 `openspec`；正常 host setup 会安装它。
最小 Debian host 不默认安装这套工具。

安装七个用户级 Codex skills：

```bash
scripts/openspec-skills
openspec --version
npx --yes skills@1.5.20 list --global --agent codex
```

脚本读取当前 `openspec --version`，从官方仓库对应的 `v<version>` release tag
安装 core 六项加 verify，不跟随上游 main。安装位置是
`~/.agents/skills/openspec-*`，通过 Skills CLI 管理，不复制到
`home/dot_codex/skills/`，也不由 chezmoi 管理。

安装后新建 Codex 任务，让它重新发现全局 skills。

## 项目按需启用

在目标仓库根目录运行：

```bash
openspec init --tools none --language Chinese
```

`--tools none` 只初始化项目规划文件，不生成项目内 skills 或命令。提交项目的
`openspec/`，不要再运行 `openspec init --tools codex` 来重复安装。

```text
openspec/
  config.yaml
  specs/<capability>/spec.md
  changes/<change-name>/
    proposal.md
    design.md
    tasks.md
    specs/<capability>/spec.md
```

`specs/` 记录当前行为；`changes/` 保存这次变更的提案、设计、任务和规格增量。
项目约束放在本仓库的 `AGENTS.md` 和 `openspec/config.yaml`，不复制到全局 skill。

未启用的仓库继续正常开发。官方 skills 会先检查 OpenSpec root；自动匹配但
没有 root 时退出 OpenSpec 流程，明确调用时再询问是否初始化，不自动创建目录。

## 使用

在 Codex 对话中显式调用：

| Skill                      | 用途                                     |
| -------------------------- | ---------------------------------------- |
| `$openspec-explore`        | 调查现状、比较方案，不改项目代码         |
| `$openspec-propose`        | 创建提案、规格、设计和任务，完成后供审阅 |
| `$openspec-apply-change`   | 执行或继续指定 change 的任务             |
| `$openspec-update-change`  | 根据新信息更新已有规划                   |
| `$openspec-sync-specs`     | 把变更规格合入项目当前规格               |
| `$openspec-verify-change`  | 对照规格、设计和任务核查实现             |
| `$openspec-archive-change` | 同步必要的规格并归档已完成 change        |

常用路径是 explore → propose → apply → verify → archive；目标明确时从 propose
开始。多个活跃 change 时明确指定名称，避免选错计划。

终端中查看状态和校验规格：

```bash
openspec list
openspec status --change <change-name>
openspec validate --all --strict --no-interactive
```

`validate` 校验规格结构，不能代替代码测试或实现验收。项目任务应写明完成信号和
验证命令；通过相关验证后再勾选完成。恢复计划时先核对当前仓库、分支和代码状态，
实现前更新已经失效的规划。可在项目配置中补充：

```yaml
operations:
  apply:
    guidance:
      - 恢复任务时先核对仓库、分支和代码状态，更新失效的规划。
      - 运行任务对应的验证，通过后再标记完成；保留验证结果。
```

这些 guidance 是给 agent 的操作说明，不是 CLI 强制执行的测试 gate。

## 更新

macOS 更新 CLI 后，重装对应 release 的全局 skills：

```bash
brew upgrade openspec
scripts/openspec-skills
```

Arch 同样在更新 `openspec` 包后运行该脚本。CLI 升级会影响所有使用它的项目，
应一并更新 skills。不要用 `npx skills update` 把这七项单独推进到 main，
也不要用项目内的 `openspec update` 管理这份全局安装。

## 从 charter-run 迁移

chezmoi 会移除旧的 `~/.codex/skills/charter-run`。`$HOME/specs` 下的既有规划和
索引保留，不自动改写。恢复一个旧计划时，再把仍需执行的范围迁入目标项目：

- `context.md` 的目标和约束进入 proposal、design 或项目 config。
- `spec.md` 中仍适用的需求整理为规格增量，区分现有行为与计划变更。
- `plan.md` 的技术决策进入 design；未完成任务和验收要求进入 tasks。
- 重新核对完成状态和验证证据，之后以 OpenSpec change 为准，不维护双份任务索引。

OpenSpec 的外置 store 目前是 Beta，默认采用项目内 `openspec/`。

## 官方来源

- [Installation](https://github.com/Fission-AI/OpenSpec/blob/v1.16.0/docs/installation.md)
- [独立 skills 分发](https://github.com/Fission-AI/OpenSpec/blob/v1.16.0/skills/README.md)
- [CLI 与初始化选项](https://github.com/Fission-AI/OpenSpec/blob/v1.16.0/docs/cli.md)

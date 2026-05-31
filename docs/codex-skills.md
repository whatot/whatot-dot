# Codex Skill 管理

Codex skills 是一组小而可管理的个人工具集，不是外部 marketplace 的镜像。
默认启用的 skill 需要保持少量、可审查，并且容易被中文请求准确触发。

源文件位置：

```text
home/dot_codex/skills/<skill>/SKILL.md
home/dot_codex/skills/<skill>/references/*.md
```

chezmoi 渲染后的位置：

```text
~/.codex/skills/<skill>/SKILL.md
~/.codex/skills/<skill>/references/*.md
```

## 生命周期

| 状态         | 含义                                   | 位置                     |
| ------------ | -------------------------------------- | ------------------------ |
| `active`     | 由 chezmoi 安装，默认对 Codex 可见。   | `home/dot_codex/skills/` |
| `incubating` | 进入默认集合前，仍在试用和打磨。       | 本文档                   |
| `reference`  | 值得回看但不直接安装的外部或本地来源。 | 本文档                   |
| `archived`   | 不再推荐使用，只在历史中保留。         | git history              |

晋升规则：只有当一个想法已经按本地工作流重写后，才移动到 `active`。
不要 symlink 或自动同步大型外部 skill 集合。

清理规则：当一个 active skill 触发不准确、和其他 skill 明显重叠，或者近期没有实际用途时，
应该降级、合并或删除。

## 已启用 Skill

| Skill                  | 用途                                                            | 触发词                                           | 审查重点                              |
| ---------------------- | --------------------------------------------------------------- | ------------------------------------------------ | ------------------------------------- |
| `charter-run`          | 在 `$HOME/specs` 下跟踪非小型任务的规划、拆分、执行和恢复状态。 | 先规划一下, 先规划, 拆任务, 按计划执行, 继续执行 | 保持阶段产物和索引规则一致。          |
| `codebase-overview`    | 产出项目全貌：功能、架构、运行流程、关键模块、优点和局限。      | 分析项目, 了解项目, 整体了解, 全貌分析           | 和 audit 保持边界，不要变成缺陷审计。 |
| `codebase-audit`       | 审查代码库中的隐藏 bug、架构风险、技术债和修复方向。            | 代码库审计, 全面检查问题, 有哪些风险             | 问题优先，避免泛泛总结。              |
| `systematic-debugging` | 在修复前先收集证据，用于排查失败、回归和不稳定问题。            | 排查问题, 查原因, 为什么失败                     | 避免连续猜测式修复。                  |
| `task-guardrails`      | 在执行前约束范围大、风险高、边界模糊或需要先评审的任务。        | 先分析, 边界, 风险, 方案                         | 保持轻量，只做范围和风险护栏。        |
| `disk-cleaner`         | 排查磁盘占用、缓存、构建产物和可清理候选项。                    | 磁盘清理, 空间占用, 缓存太大                     | 真正删除前需要明确批准。              |
| `optimize-network`     | 诊断网络慢、DNS、代理路由和 AI 工具连接问题。                   | 网络慢, 代理线路, DNS 慢                         | 先收集只读证据，再考虑调整。          |

## 试用中 Skill

暂无。创建新的 active skill 前，先在这里增加候选项。

## 参考来源

- [`github.com/wshobson/agents`](https://github.com/wshobson/agents)
  可吸收点：大型多 harness 插件市场；adapter 设计、skill 目录、校验和评估思路。
  不直接导入：对个人全局集合来说太重，只适合作为参考库。
- [`github.com/github/spec-kit`](https://github.com/github/spec-kit)
  可吸收点：分阶段 specification、规划、任务生成和执行 gate。
  不直接导入：完整命令和阶段系统比当前 dotfiles 工作流需要的更重。
- [`github.com/majiayu000/claude-arsenal`](https://github.com/majiayu000/claude-arsenal)
  可吸收点：精选 agent/skill 模式，以及值得选择性吸收的 prompt 表达。
  不直接导入：需要改写成 Codex、中文触发词和本仓库规则。

当某个参考来源变得有用时，把具体想法沉淀到 active 或 incubating skill。
不要只把知识留在聊天记录里。

## 审查清单

修改 Codex 行为，或者某个 skill 误触发时，检查已启用 skill：

- 中文 description 是否仍然匹配真实请求？
- 名字是否仍然容易显式调用？
- 是否和另一个 active skill 重叠？
- 是否需要 reference，还是正文可以继续保持紧凑？
- 是否需要新增校验规则？
- 应该继续 active、回到 incubating，还是 archived？

## 校验

运行仓库检查：

```bash
mise run check
```

Codex skill 校验脚本位于 `tests/checks/codex-skills.sh`。

当前校验内容：

- 每个托管 skill 目录都存在 `SKILL.md`。
- YAML frontmatter 以 `---` 开始和结束。
- frontmatter key 只允许 Codex skill 支持的元数据。
- `name` 存在、唯一、使用 kebab-case，并且和目录名一致。
- `description` 存在，并保持在合适长度内。
- 正文包含 H1 标题。
- 拒绝过大的 skill，把共享细节移动到 references。
- 本地 Markdown 链接必须指向存在的文件。
- 拒绝硬编码 `/Users/...` 路径。
- `rm -rf`、`sudo` 和网络变更类危险命令，需要在 skill 文本中有明确批准边界。
- `references/` 下的 Markdown 文件需要 H1 标题、保持紧凑，并通过安全边界检查。
- `charter-run` 保留必要的阶段引用和最小 example，避免后续修改悄悄破坏分阶段工作流契约。

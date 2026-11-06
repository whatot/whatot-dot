# Codex Skill 管理

Codex skills 是一组小而可管理的个人工具集，不是外部 marketplace 的镜像。
默认启用的 skill 需要保持少量、可审查，并且容易被中文请求准确触发。

源文件位置：

```text
home/dot_codex/skills/<skill>/SKILL.md
home/dot_codex/skills/<skill>/references/*.md
home/dot_codex/skills/<skill>/agents/openai.yaml
```

chezmoi 渲染后的位置：

```text
~/.codex/skills/<skill>/SKILL.md
~/.codex/skills/<skill>/references/*.md
~/.codex/skills/<skill>/agents/openai.yaml
```

## 生命周期

| 状态         | 含义                                   | 位置                     |
| ------------ | -------------------------------------- | ------------------------ |
| `active`     | 由 chezmoi 安装，默认对 Codex 可见。   | `home/dot_codex/skills/` |
| `incubating` | 进入默认集合前，仍在试用和打磨。       | 本文档                   |
| `reference`  | 值得回看但不直接安装的外部或本地来源。 | 本文档                   |
| `archived`   | 不再推荐使用，只在历史中保留。         | git history              |

晋升规则：只有当一个想法已经按本地工作流审查，并完成必要的本地适配后，才移动到 `active`。
不要 symlink 或自动同步大型外部 skill 集合。

清理规则：当一个 active skill 触发不准确、和其他 skill 明显重叠，或者近期没有实际用途时，
应该降级、合并或删除。

## 外部运行时 Skill

少数 skill 是某个 CLI 的配套操作说明，并需要跟随该 CLI 更新。它们可以作为
用户级外部 skill 安装，但不复制到 `home/dot_codex/skills/`：

| Skill           | 上游                  | 安装位置                         | 管理方式                                    |
| --------------- | --------------------- | -------------------------------- | ------------------------------------------- |
| `lark-shared`   | `larksuite/cli`       | `~/.agents/skills/lark-shared`   | `npx skills` + CLI 内嵌说明                 |
| `lark-calendar` | `larksuite/cli`       | `~/.agents/skills/lark-calendar` | `npx skills` + CLI 内嵌说明                 |
| `lark-doc`      | `larksuite/cli`       | `~/.agents/skills/lark-doc`      | `npx skills` + CLI 内嵌说明                 |
| `openspec-*`    | `Fission-AI/OpenSpec` | `~/.agents/skills/openspec-*`    | `scripts/openspec-skills`，匹配 CLI release |

只安装实际需要的 skill，不安装整个上游集合。安装、初始化、最小授权、使用和
更新流程见 [`lark-cli.md`](lark-cli.md)。实际操作时通过
`lark-cli skills read <name>` 读取与当前 CLI 版本匹配的内嵌说明。

OpenSpec 全局安装 core 的六个 skill，再加 `openspec-verify-change`，各项目只保存
`openspec/` 规划文件，不重复安装 skill。安装、升级和旧规划迁移见
[`openspec.md`](openspec.md)。

## 已启用 Skill

| Skill                  | 用途                                                | 触发词                                       | 审查重点                               |
| ---------------------- | --------------------------------------------------- | -------------------------------------------- | -------------------------------------- |
| `diagram-code`         | 生成和维护 Mermaid、D2、PlantUML 等 graph-as-code。 | 画图, 架构图, 流程图, sequence, state        | 保持可编辑、可追溯并运行最小语法校验。 |
| `reclaim-code-entropy` | 以消费者、所有权和验证证据安全化简代码库。          | 代码化简、熵回收、删代码、清理冗余、收敛抽象 | 不把静态扫描结果直接当作删除证明。     |
| `test-behavior`        | 选择独有行为验证，落实真实 E2E、隔离和工件。        | 写测试、回归测试、E2E、Mock、测试膨胀        | 不为没有行为盲区的修改增加测试。       |
| `design-ui`            | 简化产品 UI、状态与实现，并验收运行中的界面。       | 界面、UI/UX、页面布局、视觉打磨、交互重构    | 保护原有能力，取得当前视觉和交互证据。 |

## 试用中 Skill

暂无。创建新的 active skill 前，先在这里增加候选项，完成本地适配与校验后晋升。

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
- [`github.com/mattpocock/skills`](https://github.com/mattpocock/skills)
  可吸收点：反馈环优先的 diagnose、一测一改的 TDD、throwaway prototype、
  vertical slice 拆分，以及 glossary/ADR 约束下的规划讨论。
  不直接导入：slash command、Claude hooks、issue tracker setup 和个人工作流绑定较重。
- [`github.com/EveryInc/compound-engineering-plugin`](https://github.com/EveryInc/compound-engineering-plugin)
  可吸收点：SKILL.md 与 references 的加载边界、frontmatter 和 shell 安全校验、
  systematic debugging / code review 的证据链和分级思路。
  不直接导入：它是产品化插件，包含大量 agents、转换器、团队服务集成和发布流程。
- [`github.com/tt-a1i/archify`](https://github.com/tt-a1i/archify)
  可吸收点：先选 diagram mode、以 JSON IR 表达图、schema 校验、renderer
  错误驱动布局修正，以及 Mermaid 只作为输入方言的思路。
  不直接导入：HTML/export/PNG 流水线和完整 renderer 对个人全局 skill 过重。
- [`github.com/Yevanchen/reclaim-code-entropy`](https://github.com/Yevanchen/reclaim-code-entropy)
  已启用：小型 instruction-only skill；用真实消费者、动态入口、兼容义务、历史和
  生命周期所有权证明安全删减。当前保留上游正文与 UI 元数据，仅由本仓库管理安装。

测试与 UI 的共性参考随各自 skill 维护，包含采用范围和原始来源；不镜像外部手册。
项目具体测试命令、框架 API、组件与视觉参数继续留在项目中。

当某个参考来源变得有用，而且确实需要重复流程、专用资源或稳定产物格式时，
再把具体想法沉淀到 active 或 incubating skill。不要用 skill 重复模型已经具备的
通用分析、审查、调试或范围控制能力。

## 编写规则

- Load-bearing 规则放在 `SKILL.md` 对应阶段附近，不能只放在
  `references/` 里；references 只承载按需细节。
- 不要在 `SKILL.md` 里复述大段 reference 内容。需要加载 reference 时，
  用一两句话说明触发条件和目标文件。
- Skill 运行中的阶段记录、下一步菜单和临时判断留在对话里；写入文件的
  artifact 只保留对读者有价值的 durable 内容。
- 外部 workflow 默认按本地工作流改写后吸收，不镜像或自动同步。用户明确要求时，
  可以在完成内容、安全、触发和校验审查后原样纳入小型独立 skill。

## 质量约束的使用与维护

全局 `AGENTS.md` 只保留共性方向和读取入口：测试相关决策读取 `test-behavior`，
产品界面任务读取 `design-ui`。两个 skill 的正文持有约束与执行流程，
`references/principles.md` 持有定义、反例、验收细节与参考来源。
项目 `AGENTS.md` 只需指向自己的测试规范、执行命令、设计系统和组件入口，不复制全局规则。

也可显式调用 `$test-behavior` 或 `$design-ui`。涉及 UI 测试时组合使用，
不建立另一套规划流程；OpenSpec change 按需记录行为盲区和界面验收要求。
skill 与 OpenSpec 都是 agent 的操作指导，不能代替真实执行或 CI gate。

维护以实际失败为输入：

1. 定位原因：未触发、规则含糊、项目缺少标准、执行入口错误，还是缺少验收证据。
2. 只修改唯一 owner：触发条件改全局入口/description，共性决策改 skill，
   项目行为和工具差异改项目规范；同批删除重复或冲突条款。
3. 用原始案例检查能否改变错误决策，再检查一个正常案例是否被过度约束。
   涉及执行行为时检查实际结果与工件；不要用标题、固定文案或规则文本匹配代替效果验证。
4. 运行 `mise run check`，审阅完整 diff 后按正常 git 流程维护。
   参考链接只在实际需要或修改相关规则时核对，不自动同步上游内容。

当前边界样例见两个 skill 的 reference。新案例只在能澄清真实歧义时补充，
不维护每条测试的登记表，也不为每次 UI 修改复制完整状态矩阵。
首次应用时重点观察实际测试膨胀、错误修复和页面变更；本地语法校验不代表行为效果已经验证。

只应用本次质量规则时，使用稳定入口并限定目标：

```bash
scripts/chezmoi apply "$HOME/.codex/AGENTS.md" \
  "$HOME/.codex/skills/test-behavior" "$HOME/.codex/skills/design-ui"
```

安装后新建 Codex 任务以重新发现 skills。既有项目规则的迁移由各项目单独评审，
全局安装不自动改写项目文件。

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

Codex skill 校验脚本位于 `tests/cases/codex-skills.sh`。

当前校验内容：

- 每个托管 skill 目录都存在 `SKILL.md`。
- YAML frontmatter 以 `---` 开始和结束。
- frontmatter key 只允许 Codex skill 支持的元数据。
- `name` 存在、唯一、使用 kebab-case，并且和目录名一致。
- `description` 存在，并保持在合适长度内。
- `description` 不包含裸 `<placeholder>` 这类 HTML-like token。
- 正文包含 H1 标题。
- 拒绝过大的 skill，把共享细节移动到 references。
- 本地 Markdown 链接必须指向存在的文件。
- 拒绝硬编码 `/Users/...` 路径。
- `rm -rf`、`sudo` 和网络变更类危险命令，需要在 skill 文本中有明确批准边界。
- `references/` 下的 Markdown 文件需要 H1 标题、保持紧凑，并通过安全边界检查。

# Lark CLI 与 Codex Skills

`lark-cli` 由 `mise` 安装和固定版本。Codex 只安装当前需要的三个外部
skill：

- `lark-shared`：初始化、认证、身份和权限处理
- `lark-calendar`：日程、忙闲和会议室
- `lark-doc`：飞书 Docx / Wiki 文档的读取和编辑

这些 skill 由上游复制到 `~/.agents/skills/`，不由 chezmoi 管理。不要把
`~/.agents/skills/lark-*` 或 `~/.agents/.skill-lock.json` 加入仓库。

## 安装

先安装 `mise` 中固定的 CLI，并确认命令可用：

```bash
mise install
lark-cli --version
```

只为 Codex 安装所需的三个 skill：

```bash
npx --yes skills@1.5.20 add larksuite/cli \
  --skill lark-shared \
  --skill lark-calendar \
  --skill lark-doc \
  --agent codex \
  --global \
  --yes
```

这里的 `npx` 只把 `skills@1.5.20` 下载到 npm cache 中执行，不会全局安装
这个 npm package。`--global` 指 skill 的用户级作用域，因此它们可用于所有
Codex 项目。

检查安装结果：

```bash
npx --yes skills@1.5.20 list --global --agent codex
```

安装完成后新建一个 Codex 任务，让 Codex 重新发现 skill。当前安装采用
copy 模式，文件位于：

```text
~/.agents/skills/lark-shared
~/.agents/skills/lark-calendar
~/.agents/skills/lark-doc
```

## 初始化

首次使用时运行交互式初始化：

```bash
lark-cli config init
```

明确需要创建一个新的飞书应用时，可以直接进入新应用流程：

```bash
lark-cli config init --new
```

让 Codex 代为初始化时，Codex 应在后台运行 `config init --new`，把命令返回的
验证链接原样交给用户，并同时使用 `lark-cli auth qrcode` 生成二维码。不要把
App Secret、access token、验证链接或 device code 写入仓库、shell history
或文档。

## 最小权限登录

个人日历和文档默认使用 user 身份。当前三个 skill 的常用业务域是
`calendar`、`docs` 和 `drive`：

```bash
lark-cli auth login \
  --domain calendar \
  --domain docs \
  --domain drive
```

让 Codex 发起授权时使用 split flow，避免命令阻塞后用户看不到授权链接：

```bash
lark-cli auth login \
  --domain calendar \
  --domain docs \
  --domain drive \
  --no-wait \
  --json
```

Codex 从 JSON 中读取 `verification_url` 和 `device_code`，展示原始 URL 和
二维码，然后结束当前轮。用户确认授权完成后，Codex 在下一轮完成登录：

```bash
lark-cli auth login --device-code <device_code>
```

每次授权都应重新生成 URL 和 device code，不要复用旧值。检查登录身份和
token：

```bash
lark-cli auth status --json --verify
lark-cli whoami
```

user 身份用于访问个人日历和个人云空间中的文档。bot 身份只能访问应用自身
拥有或参与的资源，不能替代用户读取个人日历和云空间。

## Codex 中使用

安装后可以直接用自然语言请求：

- `查看我今天的日程`
- `查一下明天下午的忙闲时间`
- `帮我创建周五的项目例会`
- `读取这个飞书文档：<URL>`
- `把这段内容追加到这个飞书文档：<URL>`

Codex 应在实际操作前读取与当前 CLI 版本匹配的内嵌说明：

```bash
lark-cli skills read lark-shared
lark-cli skills read lark-calendar
lark-cli skills read lark-doc
```

按任务读取 reference：

```bash
lark-cli skills list lark-calendar/references
lark-cli skills read lark-calendar references/lark-calendar-schedule-meeting.md
lark-cli skills list lark-doc/references
lark-cli skills read lark-doc references/lark-doc-fetch.md
```

不要只根据 `--help` 猜测写操作参数。CLI 内嵌的 skill 和 reference 在构建时
与 CLI 版本绑定，是日历调度和文档编辑流程的真实说明。

## 常用命令

查看日程、搜索日程和查询忙闲：

```bash
lark-cli calendar +agenda --as user
lark-cli calendar +search-event \
  --query "周会" \
  --start <YYYY-MM-DD> \
  --end <YYYY-MM-DD>
lark-cli calendar +freebusy \
  --start <YYYY-MM-DD> \
  --end <YYYY-MM-DD>
```

新建或修改日程前，先读调度说明和具体命令帮助：

```bash
lark-cli skills read lark-calendar references/lark-calendar-schedule-meeting.md
lark-cli calendar +create --help
lark-cli calendar +update --help
```

读取、创建和追加飞书文档：

```bash
lark-cli skills read lark-doc
lark-cli docs +fetch --doc "<document-url-or-token>"
lark-cli docs +create --content '<title>标题</title><p>正文</p>'
lark-cli docs +update \
  --doc "<document-url-or-token>" \
  --command append \
  --content '<p>追加内容</p>'
```

文档精确编辑、媒体处理和历史回滚需要先读 `lark-doc` 指定的对应
reference。文档复制、云盘权限和评论属于 `lark-drive`；电子表格和多维表格
分别属于 `lark-sheets` 和 `lark-base`，需要时再单独安装，不要预装整个
Lark skill 集合。

## 安全和错误处理

- 写操作前确认目标、内容和用户意图；危险请求先用 `--dry-run`。
- 高风险写操作会以退出码 `10` 和 `confirmation_required` 返回。只有获得
  用户明确同意后，才能在原命令末尾追加 `--yes` 重试。
- 文件参数只接受当前工作目录下的相对路径，不要传绝对路径。
- JSON 成功响应以进程退出码 `0` 或顶层 `ok == true` 判断，不要检查
  `code == 0`。
- 权限不足时检查 `missing_scopes`、`console_url` 和 `hint`。user 身份可以
  增量授权缺失 scope；bot 身份应去开发者后台增加权限，不能执行 user
  login。

## 更新

这个仓库通过 `mise` 管理 `lark-cli`，不要运行 `lark-cli update` 绕过固定
版本。更新时先修改 `home/dot_config/mise/config.toml` 中的版本，再运行：

```bash
mise install
npx --yes skills@1.5.20 update \
  lark-shared \
  lark-calendar \
  lark-doc \
  --global \
  --yes
```

更新后重新检查 CLI、登录状态和已安装 skill：

```bash
lark-cli --version
lark-cli auth status --json --verify
npx --yes skills@1.5.20 list --global --agent codex
```

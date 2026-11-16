# Clippy 基线与例外

策略是广泛启用成熟规则组，再以具体理由收窄；不逐条审批所有 lint，也不全开每个组。
这是本地默认取舍，不代表 Clippy 官方建议所有项目启用 `pedantic`。

## 默认选择

| 范围          | 默认方式                                          | 判断依据                                                  |
| ------------- | ------------------------------------------------- | --------------------------------------------------------- |
| `all`         | 启用整个组，保留 `correctness` 的 deny 级别。     | 覆盖成熟的正确性、可疑代码、复杂度、性能和风格规则。      |
| `pedantic`    | 新项目整体启用；存量项目先审阅诊断，再建立 gate。 | 覆盖更广，接受针对实际误报与不适用规则的例外。            |
| `restriction` | 按项目策略选择单项。                              | 限制语言/表达方式，有些规则互相冲突；官方明确不建议全开。 |
| `nursery`     | 不作为默认 gate，单项成熟后再评估。               | 官方说明仍可能有 bug 或需要完善，不建议全开。             |
| `cargo`       | 发布 crate 时按需要选择。                         | 包元数据与依赖建议不都适合内部应用。                      |
| rustc lint    | 保留已有级别，补实际安全与兼容要求。              | 不与 Clippy 分组混为同一套开关。                          |

`pedantic` 的广覆盖会带来维护成本：官方允许其有意产生部分误报。
不为清零把普通数据改成验证框架、给内部 API 补冗余文档或增加无消费者的抽象。
对框架规定的函数签名、prelude、数据结构和单线程约束，选择具体例外。

## 新 workspace 的起点

没有既定 lint 规范时，可以从以下 manifest 配置开始；已有项目先合并现有策略，不替换整张表。

```toml
[workspace.lints.rust]
unsafe_op_in_unsafe_fn = "warn"

[workspace.lints.clippy]
all = { level = "warn", priority = -1 }
pedantic = { level = "warn", priority = -1 }
correctness = "deny"
```

每个 member，包括根目录的 package，都需要在自身 manifest 显式继承：

```toml
[lints]
workspace = true
```

单 package 使用 `[lints.rust]` / `[lints.clippy]`，不加 workspace 层。
组的低 priority 让单项覆盖生效；不要降低已有 `deny` / `forbid`，也不要为了本模板升级 MSRV。
固定项目工具链，避免编译器更新在无关变更中突然引入新的 CI 失败。

## BeautifulRust 配置怎样取舍

它启用 `all + pedantic`，加一组单项规则，同时也关闭若干规则；并非 Clippy 的所有规则全开。
不整体复制 `lints.toml` / `clippy.toml`，按本地边界合并：

- `unwrap_used`、`expect_used`、`panic_in_result_fn`：依项目 panic 政策选择。
  已经禁止 `expect` 的项目不能引入上游的 `expect_used = "allow"` 或测试全局豁免。
- `undocumented_unsafe_blocks`、`multiple_unsafe_ops_per_block`：在允许且实际包含 unsafe 的项目评估；
  不用它们替换已有 unsafe 禁令。
- `allow_attributes_without_reason`、`allow_attributes`：工具链支持时可用于管理抑制；
  配合最小范围、具体理由，不以成批属性替代修复。
- `missing_docs`、`missing_errors_doc`、`missing_panics_doc`、`exhaustive_enums`：
  按独立发布 API 的承诺与内部代码文档需要决定作用域。`pedantic` 内的文档规则也要这样审阅。
- `print_stdout` / `print_stderr`：库禁止直出可能有价值，CLI 的正式输出则是产品行为。
- `max-fn-params-bools = 0` 不作为基线；自然开关不应被迫增加 enum。其他表达/转换限制同样要守住语义，
  不因启用 lint 而悄悄改变饱和、截断、回绕或稳定输出。

## 存量接入、CI 与维护

先查看 manifest、member 继承、`clippy.toml`、源码属性、CLI flags 和 CI 实际入口，
检查优先级与覆盖；不能只看根 manifest 就宣称已启用全 workspace。
在项目允许的目标和 feature 组合上审阅新增组的完整诊断；沿用现有 wrapper，
不要自动使用 `--all-features` 或运行跨平台不可构建目标。

新诊断区分真实问题、不适用规则与存量债务。修复有实际收益的问题，对不适用项设置具体理由的例外；
大范围修复单独安排，不混入普通功能变更，也不全局关闭整个组掩盖债务。
CI 原来严格时保持严格；新增基线尚未收敛时明确它只是非阻断审阅，不能宣称已受 gate 保护。
诊断收敛后，在项目检查命令中用 `-D warnings` 阻断，不在源码写 `#![deny(warnings)]`。

单处例外优先用带 `reason` 的 `#[expect(clippy::具体规则, reason = "具体原因")]`，
使过期例外能被发现；只在当前工具链支持且该 lint 确实触发时使用。
规则对整个项目/某类 crate 不适用时，在对应 manifest 集中设置具体 lint 的 allow 并说明理由。
条件编译或 MSRV 不适合 `expect` 时使用有理由的最窄 `allow`。不使用无理由的大范围放行。

工具链升级时审阅新增/改名 lint、过期抑制和 CI 覆盖；不自动拉取上游配置。
Clippy 负责静态诊断，测试策略仍由 `test-behavior` 持有，不因启用 lint 增加测试数量。

## 依据

- [Clippy Usage](https://doc.rust-lang.org/clippy/usage.html)：分组与级别、局部覆盖及工作区调用。
- [Clippy Lints](https://doc.rust-lang.org/clippy/lints.html)：各组定位、`pedantic` 误报，以及
  `restriction` / `nursery` 不应整体启用的边界。
- [BeautifulRust lints](https://github.com/morganlinton/BeautifulRust/blob/b9718436d77ee7bcf17cdcb6aa27628feb95d97a/lints/lints.toml)：
  取舍对象；不是本地模板的直接同步来源。

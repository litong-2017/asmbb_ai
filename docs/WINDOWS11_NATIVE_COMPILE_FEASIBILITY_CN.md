# Windows 11 原生编译可行性验证

本文档验证“只在 Windows 11 原生环境下，不依赖 WSL/Linux，是否可以编译 AsmBB 项目”的可行性。

这里的“编译项目”需要拆成三个层次：

1. 编译主题样式：把 `www/templates/**/*.less` 编译为 `.css`。
2. 汇编主程序：把 `source/engine.asm` 编译为 `www/engine`。
3. 构建完整发布包：生成 `engine`、`libsqlite3.so`、`ld-musl-i386.so` 并打包 `asmbb.tar.gz`。

截至 2026-07-11 的实测结论是：Windows 11 原生环境可以稳定完成第 1 项；第 2 项已经可以启动 FASM 汇编并解析 FreshLib，但当前源码和 `FreshLibDev/freshlib` 组合不能直接产出 `www/engine`，失败点是缺少 `StrExtractMem` 符号；第 3 项按现有脚本仍不适合纯 Windows 原生完成。

## 当前验证环境

当前工作区：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git
```

项目目录：

```text
asmbb/
```

FreshLib 依赖：

```text
FreshLibDev/freshlib
```

Windows PATH 中已找到的工具：

```text
fasm.exe   D:\_Scoop\shims\fasm.exe
fasmw.exe  D:\_Scoop\shims\fasmw.exe
fresh.exe  D:\_Scoop\shims\fresh.exe
```

`FreshLibDev` 目录下未发现项目自带的 `fasm.exe`、`fasmw.exe` 或 `Fresh.exe`。

## 可行性结论

| 项目 | Windows 11 原生可行性 | 当前验证结果 | 说明 |
|---|---|---|---|
| 主题样式 `.less -> .css` | 可行 | 已验证通过 | 使用 `npm run build:styles`，不依赖 WSL |
| 主程序 `source/engine.asm -> www/engine` | 当前未通过 | 已实测失败 | FASM 可启动，FreshLib include 可解析，但缺少 `StrExtractMem` 定义 |
| Fresh IDE 打开 `source/engine.fpr` 构建 | 条件可行，未完成图形界面实测 | 未验证 | `engine.fpr` 明确记录主文件、输出和 `TargetOS` 变量，可能由 Fresh IDE 补齐部分项目上下文 |
| `musl_sqlite/build` | 不推荐 | 未执行 | 依赖 Linux shell、gcc/make、musl 构建环境 |
| 完整 `install/create_release.sh` 发布包 | 不推荐 | 未执行 | 运行时会触发 Linux 工具链、动态库构建和发布打包 |

## 已验证：主题样式可原生编译

现代样式构建支持 Windows PowerShell：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm run build:styles
```

验证结果：

```text
Less files: 103
Linked less files: 53
Real less files: 50
CSS compiled: 103
Failed: 0
```

说明：

- `scripts/build-styles.mjs` 会处理 Windows checkout 下的一行路径占位 `.less` 文件。
- `Urban Sunrise` 中不兼容 Node 版 Less 的旧语法已迁移。
- 生成的 `www/templates/**/*.css` 是可再生成产物，已通过 `.gitignore` 排除。

## 已验证：命令行 FASM 尚不能直接生成 engine

主入口文件：

```text
asmbb/source/engine.asm
```

该文件依赖 FreshLib：

```asm
include "%lib%/freshlib.inc"
include "%lib%/freshlib.asm"
include "%lib%/data/bbcode.asm"
include "%lib%/data/minimag.asm"
```

并依赖目标平台变量：

```asm
uses sqlite3:"%TargetOS%/sqlite3.inc"
```

本次使用 Windows 原生 FASM 执行：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb

$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
$env:TargetOS = "Linux"
fasm source\engine.asm www\engine
```

FASM 版本：

```text
flat assembler version 1.73.34
```

实际结果：

```text
source\render2.asm [1288]:
        stdcall StrExtractMem, edx ; remaining arguments from the stack.
...\FreshLibDev\freshlib/macros/_stdcall.inc [272] stdcall [16]:
  call proc
processed: call StrExtractMem
error: undefined symbol 'StrExtractMem'.
```

同时确认：

- `www\engine` 未生成。
- `source\render2.asm` 中有 3 处 `StrExtractMem` 引用。
- 当前 `FreshLibDev\freshlib` 中未搜索到 `StrExtractMem` 定义。

这说明 Windows 原生 FASM 工具链已经能进入真实项目汇编阶段，问题不再是“没有 FASM”，而是当前 AsmBB 源码和本地 FreshLib 依赖之间存在未满足的符号、版本或项目配置条件。它可能不是 Windows 特有问题，但在当前 Windows 11 原生命令行环境下，不能认定主程序已可直接编译。

## `engine.fpr` 对可行性的意义

`source/engine.fpr` 是 Fresh IDE 项目文件，当前文件中能看到这些关键信息：

```text
MAIN      engine.asm
output    ../www/engine
VARS      TargetOS Linux|Win32|KolibriOS
```

因此，使用 Fresh IDE 打开 `source/engine.fpr` 仍然是比裸 `fasm source\engine.asm www\engine` 更接近原项目工作流的验证路径。Fresh IDE 可能会加载项目变量、输出目标和附加上下文。

但在没有完成 Fresh IDE 图形界面构建验证前，本文档不把主程序汇编标记为“通过”。

## 推荐的下一步原生汇编验证

### 方案 A：使用 Fresh IDE

准备：

- 使用 PATH 中已有的 `fresh.exe` 或安装 Fresh IDE for Windows。
- 确保 Fresh IDE 能找到 FASM。
- 配置 FreshLib 路径到：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib
```

操作：

1. 打开项目文件：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb\source\engine.fpr
```

2. 确认主文件是：

```text
source/engine.asm
```

3. 确认目标平台是：

```text
Linux
```

4. 构建项目。
5. 检查输出文件：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb\www\engine
```

验收标准：

- 构建过程无 FASM/FreshLib include 错误。
- 不再出现 `StrExtractMem` undefined symbol。
- `www\engine` 被生成或更新时间改变。
- 如果通过 WSL/Linux 检查，`file www/engine` 应显示 ELF 可执行文件。

### 方案 B：修正依赖后重试 FASM 命令行

命令行方式已经证明 FASM 和 FreshLib include 路径基本可用，下一步应优先处理 `StrExtractMem`：

- 确认当前 AsmBB checkout 需要匹配哪个 FreshLib 版本。
- 在 FreshLib 历史版本或上游源码中查找 `StrExtractMem`。
- 如果该符号已被重命名或删除，需要更新 `source/render2.asm` 中对应调用，或切换到兼容 FreshLib。

处理后再执行：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb

$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
$env:TargetOS = "Linux"
fasm source\engine.asm www\engine
```

## 不建议 Windows 原生完成完整发布包

完整发布涉及：

```text
install/create_release.sh
musl_sqlite/build
```

这些脚本依赖：

- Bash
- `rsync`
- `tar`
- `gcc -m32`
- `make`
- musl 构建流程
- Linux 动态库输出

虽然 Windows 可以通过 Git Bash、MSYS2 或其他兼容层运行部分 shell 命令，但这已经不是“纯 Windows 原生编译”，而且 `musl_sqlite/build` 的目标就是 Linux 运行库：

```text
libsqlite3.so
ld-musl-i386.so
```

因此完整发布包仍建议使用 WSL/Linux。

## 最小原生可行环境

如果只要求在 Windows 11 原生环境中“编译样式 + 尝试汇编 engine”，最小工具集是：

- Git for Windows
- Node.js
- npm
- FASM for Windows 或 Fresh IDE
- FreshLib 源码目录 `FreshLibDev/freshlib`

不需要：

- WSL
- Linux gcc
- musl
- `rsync`
- `tar`

但如果要生成完整可部署发布包，则仍需要 WSL/Linux。

## 当前结论

当前机器上的实际验证结论：

```text
Windows 原生样式编译：通过
Windows 原生主程序汇编：未通过，FASM 失败于 undefined symbol 'StrExtractMem'
Windows 原生完整发布包：不推荐，现有脚本依赖 Linux 工具链
```

更准确的判断：

- “仅编译样式资源”：Windows 11 原生可行，已验证。
- “仅汇编出 Linux 目标 engine”：当前 Windows 11 原生命令行 FASM 未通过；需要先解决 `StrExtractMem` 缺失或使用 Fresh IDE 完成进一步验证。
- “编译并打完整发布包”：Windows 11 原生不作为推荐路径，应使用 WSL/Linux。

因此，如果“仅仅编译该项目”指的是只跑前端样式构建，结论是可行；如果指的是生成 `www\engine`，当前本地源码/依赖组合在 Windows 11 原生环境下尚未通过；如果指的是发布包，则仍应走 WSL/Linux。

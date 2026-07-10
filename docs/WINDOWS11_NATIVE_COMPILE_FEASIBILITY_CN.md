# Windows 11 原生编译可行性验证

本文档验证“只在 Windows 11 原生环境下，不依赖 WSL/Linux，是否可以编译 AsmBB 项目”的可行性。

这里的“编译项目”需要拆成三个层次：

1. 编译主题样式：把 `www/templates/**/*.less` 编译为 `.css`。
2. 汇编主程序：把 `source/engine.asm` 编译为 `www/engine`。
3. 构建完整发布包：生成 `engine`、`libsqlite3.so`、`ld-musl-i386.so` 并打包 `asmbb.tar.gz`。

结论是：Windows 11 原生环境可以稳定完成第 1 项；第 2 项理论上可行但依赖 Fresh IDE/FASM 和正确的 FreshLib/TargetOS 配置，当前机器尚未安装工具，未完成实测；第 3 项按现有脚本不适合纯 Windows 原生完成。

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

已验证命令：

```powershell
Get-Command fasm -ErrorAction SilentlyContinue
Get-Command fasmw -ErrorAction SilentlyContinue
Get-Command Fresh -ErrorAction SilentlyContinue
Get-ChildItem -Recurse ..\FreshLibDev -Include fasm.exe,fasmw.exe,Fresh.exe -File
```

当前结果：

```text
未在 Windows PATH 中找到 fasm / fasmw / Fresh。
未在 FreshLibDev 目录下找到 fasm.exe / fasmw.exe / Fresh.exe。
```

因此当前机器无法直接实测主程序汇编，只能验证源码条件和样式构建。

## 可行性结论

| 项目 | Windows 11 原生可行性 | 当前验证结果 | 说明 |
|---|---|---|---|
| 主题样式 `.less -> .css` | 可行 | 已验证通过 | 使用 `npm run build:styles`，不依赖 WSL |
| 主程序 `source/engine.asm -> www/engine` | 条件可行 | 未实测 | 需要安装 Fresh IDE 或 FASM for Windows |
| `musl_sqlite/build` | 不推荐 | 未执行 | 依赖 Linux shell、gcc/make、musl 构建环境 |
| 完整 `install/create_release.sh` 发布包 | 不推荐 | 仅语法检查通过 | 运行时会触发 Linux 工具链和发布打包 |

## 已验证：主题样式可原生编译

现代样式构建已支持 Windows PowerShell：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm install
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

## 主程序原生汇编的条件

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

FreshLib 中 Linux 目标宏会生成 ELF：

```text
FreshLibDev/freshlib/macros/Linux/_executable.inc
```

其中包含：

```asm
TargetOS equ Linux
format ELF executable
interpreter LINUX_INTERPRETER
```

因此，从源码结构看，Windows 上的 FASM/Fresh IDE 只要能解析 `%lib%` 和 `%TargetOS%`，理论上可以交叉汇编出 Linux ELF 格式的 `www/engine`。但这个产物不能直接在 Windows 原生环境运行。

## 推荐的 Windows 原生汇编验证步骤

### 方案 A：使用 Fresh IDE

这是最接近原项目工作流的方式。

准备：

- 安装 Fresh IDE for Windows。
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
- `www/engine` 被生成或更新时间改变。
- 如果通过 WSL 检查，`file www/engine` 应显示 ELF 可执行文件。

### 方案 B：使用 FASM for Windows 命令行

这是实验性方式，可能不如 Fresh IDE 稳定，因为 `.fpr` 中的项目变量和输出目标需要手动补齐。

准备：

- 安装 FASM for Windows，并让 `fasm.exe` 位于 PATH。

PowerShell 示例：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb

$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
$env:TargetOS = "Linux"

fasm source\engine.asm www\engine
```

如果失败，优先检查：

- 是否能打开 `%lib%/freshlib.inc`。
- 是否能打开 `%TargetOS%/sqlite3.inc`。
- FreshLib 的 Linux 宏是否被正确加载。
- 当前 FASM 版本是否支持该项目使用的宏。

命令行方式通过后，再用：

```powershell
Get-Item www\engine
```

确认输出文件存在。

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
Windows 原生主程序汇编：未验证，缺少 fasm/fasmw/Fresh 工具
Windows 原生完整发布包：不推荐，现有脚本依赖 Linux 工具链
```

更准确的判断：

- “仅编译样式资源”：Windows 11 原生可行，已验证。
- “仅汇编出 Linux 目标 engine”：Windows 11 原生条件可行，需要安装 Fresh IDE/FASM 后验证。
- “编译并打完整发布包”：Windows 11 原生不作为推荐路径，应使用 WSL/Linux。

## 后续验证清单

安装 Fresh IDE 或 FASM for Windows 后，按以下顺序验证：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb

npm install
npm run build:styles

$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
$env:TargetOS = "Linux"
fasm source\engine.asm www\engine
```

如果命令行 FASM 失败，改用 Fresh IDE 打开：

```text
source/engine.fpr
```

并在 Fresh IDE 中配置目标平台和 FreshLib 路径。


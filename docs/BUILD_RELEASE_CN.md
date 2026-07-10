# AsmBB 中文构建与发布文档

本文档说明 `asmbb` 在当前源码布局下的构建、运行库生成和发布包打包流程，并列出需要准备的工具与环境。

## 源码布局与依赖关系

当前工作区建议保持如下目录关系：

```text
0_git/
  asmbb/                    AsmBB 项目源码
  FreshLibDev/
    freshlib/               AsmBB 构建所需 FreshLib 依赖
```

`asmbb/source/engine.asm` 通过 `%lib%` 引用 FreshLib：

```asm
include "%lib%/freshlib.inc"
include "%lib%/freshlib.asm"
include "%lib%/data/bbcode.asm"
include "%lib%/data/minimag.asm"
```

因此构建前必须确保 `%lib%` 指向 `FreshLibDev/freshlib`。

## 需要的工具或环境

### 必需环境

- Linux 构建环境：发布脚本和运行库构建脚本是 shell 脚本，建议在 Linux 或 WSL 中执行。
- x86 / x86-64 Linux 目标环境：AsmBB 运行目标是 Linux FastCGI 服务。
- FreshLib：当前工作区依赖路径为 `../FreshLibDev/freshlib`。
- FASM 或 Fresh IDE：用于从 `source/engine.asm` / `source/engine.fpr` 构建 `www/engine`。

### 汇编构建工具

- `fasm`：Flat Assembler 命令行工具。
- 或 Fresh IDE：可直接打开 `source/engine.fpr` 构建项目。

构建时需要设置：

- `TargetOS=Linux`
- `%lib%` 指向 FreshLib 目录
- 输出目标为 `www/engine`

在 Windows PowerShell 中可临时设置：

```powershell
$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
```

在 Linux / WSL 中可临时设置：

```sh
export lib=/path/to/0_git/FreshLibDev/freshlib
```

### 发布脚本工具

`install/create_release.sh` 需要：

- `bash`
- `cp`
- `mkdir`
- `rm`
- `tar`
- `rsync`
- 可执行权限支持

### 主题样式工具

各主题的 `compile_styles.sh` 会调用：

- `clessc`

脚本会把主题目录下的 `.less` 编译为同名 `.css`。发布脚本会编译这些主题：

- `www/templates/Wasp`
- `www/templates/Light`
- `www/templates/mobile`
- `www/templates/MoLight`
- `www/templates/Urban Sunrise`

### musl 与 SQLite 构建工具

`musl_sqlite/build` 需要：

- `gcc`
- `tar`
- `unzip`
- `wget`
- `make`
- 32 位编译支持，例如 `gcc -m32` 可用
- 可联网下载源码，或提前准备源码包

脚本支持三种 SQLite 变体：

```sh
./build sqlite
./build sqleet
./build sqlitemc
```

默认使用 `sqlitemc`。发布脚本固定调用：

```sh
./build sqlitemc
```

## 构建流程

### 1. 准备 FreshLib 路径

确认 `FreshLibDev/freshlib` 存在：

```sh
ls ../FreshLibDev/freshlib
```

设置 `%lib%` 对应的环境变量。Linux / WSL 示例：

```sh
export lib=$(realpath ../FreshLibDev/freshlib)
```

### 2. 构建 AsmBB 主程序

推荐使用 Fresh IDE 打开：

```text
asmbb/source/engine.fpr
```

确认目标平台为 Linux，然后构建。构建产物应生成到：

```text
asmbb/www/engine
```

如果使用命令行 FASM，需要确保命令行环境能解析 FreshLib 使用的项目宏和变量。构建前应检查：

- `source/engine.asm` 是主文件。
- `TargetOS` 为 `Linux`。
- `%lib%` 指向 `FreshLibDev/freshlib`。
- 输出文件为 `../www/engine`。

### 3. 构建 musl + SQLite 运行库

进入运行库目录：

```sh
cd asmbb/musl_sqlite
./build sqlitemc
```

成功后应生成：

```text
libsqlite3.so
ld-musl-i386.so
```

如果脚本提示库已经存在，需要重建时先删除旧文件：

```sh
rm -f libsqlite3.so ld-musl-i386.so
./build sqlitemc
```

### 4. 编译主题样式

发布脚本会自动编译主题样式。也可以单独进入主题目录执行：

```sh
cd asmbb/www/templates/Wasp
./compile_styles.sh
```

如果提示 `clessc: command not found`，需要先安装 `clessc`。

### 5. 创建发布包

进入安装目录：

```sh
cd asmbb/install
./create_release.sh
```

脚本会：

1. 创建临时目录 `install/asmbb/`。
2. 编译主题 Less 样式。
3. 执行 `../musl_sqlite/build sqlitemc`。
4. 复制 `../www/engine`。
5. 复制 `../musl_sqlite/*.so`。
6. 复制 `www/images` 和 `www/templates`。
7. 复制 `.htaccess`、`lighttpd.conf`、`License.txt`、`manifest.uuid`、`install.txt`。
8. 生成 `install/asmbb.tar.gz`。
9. 如不存在 `install/unpack.tar.gz`，则创建该包。
10. 删除临时目录 `install/asmbb/`。

发布产物：

```text
asmbb/install/asmbb.tar.gz
asmbb/install/unpack.tar.gz
```

## 发布包内容

最终发布包应包含：

- `engine`
- `libsqlite3.so`
- `ld-musl-i386.so`
- `images/`
- `templates/`
- `.htaccess`
- `lighttpd.conf`
- `License.txt`
- `manifest.uuid`
- `install.txt`

运行时第一次启动会在部署目录生成：

```text
board.sqlite
```

## 验证清单

发布前建议逐项确认：

- `www/engine` 是最新源码构建的二进制。
- `musl_sqlite/libsqlite3.so` 和 `musl_sqlite/ld-musl-i386.so` 存在。
- 主题 `.less` 已成功生成 `.css`。
- `install/asmbb.tar.gz` 是本次重新生成的文件。
- 发布包解压后包含 `engine`、两个 `.so` 文件、`templates/` 和 `images/`。
- `_FOSSIL_`、本地数据库、临时目录没有进入发布包或 Git 提交。

## 常见问题

### 找不到 FreshLib

现象通常是 FASM 报错无法打开：

```text
%lib%/freshlib.inc
```

处理方式：设置 `lib` 环境变量，或在 Fresh IDE 中配置库路径到 `FreshLibDev/freshlib`。

### clessc 不存在

主题样式脚本依赖 `clessc`。安装后重新执行：

```sh
cd asmbb/install
./create_release.sh
```

### gcc -m32 不可用

`musl_sqlite/build` 使用 32 位编译参数。如果缺少 32 位构建支持，需要安装发行版对应的 multilib / 32 位开发包。

### 发布包里 engine 不是最新

`install/create_release.sh` 只复制 `www/engine`，不会自动从 `source/engine.asm` 编译主程序。发布前必须先完成主程序构建。

## 手动提交

本文档新增后可手动提交：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
git add docs/BUILD_RELEASE_CN.md
git commit -m "Add Chinese build and release guide"
git push
```


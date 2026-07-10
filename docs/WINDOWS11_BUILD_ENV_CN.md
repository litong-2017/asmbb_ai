# Windows 11 编译环境准备文档

本文档说明如何在 Windows 11 上准备 `asmbb` 的编译与发布环境。AsmBB 的目标运行环境是 Linux FastCGI 服务，因此推荐方案是在 Windows 11 上使用 WSL2 准备 Linux 构建环境；Windows 原生环境主要用于代码管理、编辑和 Fresh IDE/FASM 辅助构建。

## 推荐方案

建议采用：

```text
Windows 11
  Git for Windows / 编辑器 / Fresh IDE 可选
  WSL2 + Ubuntu
    FASM
    FreshLib 路径
    gcc / make / tar / unzip / wget / rsync
    Node.js / npm / less
```

原因：

- `install/create_release.sh` 是 Bash 脚本。
- `musl_sqlite/build` 依赖 Linux 工具链和 `gcc -m32`。
- 发布包目标是 Linux 下运行的 `engine`、`libsqlite3.so`、`ld-musl-i386.so`。

## 当前源码布局

当前工作区路径：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git
```

建议保持：

```text
0_git/
  asmbb/
  FreshLibDev/
    freshlib/
```

在 WSL 中对应路径通常是：

```text
/mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git
```

AsmBB 主入口：

```text
asmbb/source/engine.asm
```

FreshLib 依赖：

```text
FreshLibDev/freshlib
```

构建产物目标：

```text
asmbb/www/engine
```

## Windows 11 基础工具

Windows 侧建议安装：

- Windows Terminal
- Git for Windows
- VS Code 或其他编辑器
- Fresh IDE，可选
- FASM for Windows，可选

如果主要用 WSL2 构建，Windows 侧不强制安装 FASM；但 Fresh IDE 对查看 `.fpr` 项目文件和理解项目结构有帮助。

## 安装 WSL2

以管理员身份打开 PowerShell：

```powershell
wsl --install -d Ubuntu
```

安装完成后重启系统，打开 Ubuntu，按提示创建 Linux 用户。

确认 WSL 版本：

```powershell
wsl -l -v
```

如果 Ubuntu 不是版本 2，执行：

```powershell
wsl --set-version Ubuntu 2
```

## 安装 Linux 构建工具

在 Ubuntu / WSL 里执行：

```sh
sudo apt update
sudo apt install -y build-essential gcc-multilib g++-multilib make tar unzip wget rsync git dos2unix nodejs npm
```

这些工具对应用途：

- `build-essential`：基础 C/C++ 构建工具。
- `gcc-multilib`、`g++-multilib`：支持 `gcc -m32`。
- `make`：构建 musl 和 SQLite 时使用。
- `tar`、`unzip`：解压源码包。
- `wget`：下载 musl、SQLite、SQLite3MC 等源码。
- `rsync`：发布脚本复制 `images/` 和 `templates/`。
- `git`：源码管理。
- `dos2unix`：必要时修正脚本换行。
- `nodejs`、`npm`：可用于准备 Less 编译兼容工具。

## 准备现代样式构建工具

现代化样式构建使用 Node.js、npm 和项目内的 Less 依赖，不再要求全局安装 `clessc`。

在 Windows 11 PowerShell 中执行：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm install
npm run build:styles
```

在 WSL/Linux 中执行：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb
npm ci
npm run build:styles
```

脚本会自动处理 `Light`、`MoLight` 等主题中的一行路径占位 `.less` 文件，并输出对应 `.css`。

## 准备 clessc（legacy）

主题样式脚本调用的是：

```sh
clessc "$file" -o "${file%.*}.css"
```

如果系统能直接安装 `clessc`，优先使用系统包。若没有现成包，可以安装 `less` 并创建一个兼容包装脚本。

安装 Less：

```sh
sudo npm install -g less
```

创建 `clessc` 包装脚本：

```sh
sudo tee /usr/local/bin/clessc >/dev/null <<'EOF'
#!/usr/bin/env sh
if [ "$2" = "-o" ] && [ -n "$3" ]; then
  exec lessc "$1" "$3"
fi
exec lessc "$@"
EOF
sudo chmod +x /usr/local/bin/clessc
```

验证：

```sh
which clessc
clessc --version
```

## 安装 FASM

可以在 WSL 中安装或手动下载 FASM。

如果发行版软件源提供：

```sh
sudo apt install -y fasm
```

如果没有可用包，从 Flat Assembler 官网下载 Linux 版本，解压后把 `fasm` 放入 PATH。例如：

```sh
mkdir -p ~/tools
cd ~/tools
# 下载并解压 fasm 后，确保 fasm 可执行
chmod +x ~/tools/fasm/fasm
echo 'export PATH="$HOME/tools/fasm:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

验证：

```sh
fasm
```

如果命令能显示 FASM 用法或版本信息，即为可用。

## 设置 FreshLib 路径

进入当前工作区：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git
```

确认 FreshLib 存在：

```sh
ls FreshLibDev/freshlib/freshlib.inc
ls FreshLibDev/freshlib/freshlib.asm
```

设置环境变量：

```sh
export lib=/mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/FreshLibDev/freshlib
```

如果希望每次进入 WSL 自动生效：

```sh
echo 'export lib=/mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/FreshLibDev/freshlib' >> ~/.bashrc
source ~/.bashrc
```

注意：AsmBB 源码中使用的是 `%lib%`，FreshLib/FASM 构建流程会依赖这个库路径解析到 `FreshLibDev/freshlib`。

## 修正脚本换行与权限

如果 shell 脚本从 Windows 侧编辑过，建议在 WSL 中执行：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb
dos2unix install/create_release.sh musl_sqlite/build www/templates/*/compile_styles.sh
chmod +x install/create_release.sh musl_sqlite/build www/templates/*/compile_styles.sh
```

如果通配符因为目录名含空格导致报错，可以单独处理：

```sh
dos2unix "www/templates/Urban Sunrise/compile_styles.sh"
chmod +x "www/templates/Urban Sunrise/compile_styles.sh"
```

## 编译主程序

推荐优先用 Fresh IDE 打开项目：

```text
asmbb/source/engine.fpr
```

确认：

- 主文件是 `source/engine.asm`。
- `TargetOS` 是 `Linux`。
- FreshLib 路径指向 `FreshLibDev/freshlib`。
- 输出文件是 `www/engine`。

如果使用 WSL 命令行 FASM，需要确保项目宏、`TargetOS` 和 FreshLib 路径都能被当前构建方式正确解析。构建完成后检查：

```sh
ls -l asmbb/www/engine
file asmbb/www/engine
```

预期 `www/engine` 是 Linux 可执行文件。

## 编译 musl + SQLite 运行库

在 WSL 中执行：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb/musl_sqlite
./build sqlitemc
```

成功后应生成：

```text
libsqlite3.so
ld-musl-i386.so
```

检查：

```sh
ls -l libsqlite3.so ld-musl-i386.so
file libsqlite3.so ld-musl-i386.so
```

如果提示 `gcc -m32` 相关错误，通常是 32 位开发环境不完整，重新确认已安装：

```sh
sudo apt install -y gcc-multilib g++-multilib
```

## 编译主题样式

单独验证一个主题：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb/www/templates/Wasp
./compile_styles.sh
```

如果成功，会从 `.less` 生成对应 `.css`。

## 创建发布包

发布前确认 `asmbb/www/engine` 已经是最新构建产物。然后执行：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb/install
./create_release.sh
```

成功后生成：

```text
asmbb/install/asmbb.tar.gz
asmbb/install/unpack.tar.gz
```

检查发布包内容：

```sh
tar -tzf asmbb.tar.gz | head
tar -tzf asmbb.tar.gz | grep -E 'engine$|libsqlite3.so|ld-musl-i386.so|templates/|images/' | head
```

## Windows 原生方式的边界

Windows 原生环境可以做：

- Git 提交和推送。
- 编辑源码和文档。
- 使用 Fresh IDE 查看或尝试构建 `.fpr`。
- 使用 FASM for Windows 做部分实验。

但不建议只用 Windows 原生环境完成完整发布，因为：

- 发布脚本依赖 Bash 和 Unix 工具。
- `musl_sqlite/build` 依赖 Linux 工具链。
- 最终运行目标是 Linux FastCGI。
- `libsqlite3.so` 和 `ld-musl-i386.so` 是 Linux 运行库。

完整发布包建议始终在 WSL2 或真实 Linux 环境中生成。

## 常见问题

### WSL 中找不到 D 盘源码

确认路径在：

```sh
ls /mnt/d
```

如果 D 盘未挂载，重启 WSL：

```powershell
wsl --shutdown
```

然后重新打开 Ubuntu。

### 找不到 FreshLib

检查：

```sh
echo $lib
ls "$lib/freshlib.inc"
```

如果不存在，重新设置：

```sh
export lib=/mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/FreshLibDev/freshlib
```

### create_release.sh 权限不足

执行：

```sh
chmod +x asmbb/install/create_release.sh
chmod +x asmbb/musl_sqlite/build
```

### clessc: command not found

现代构建流程不再依赖 `clessc`。在 Windows 11 中请进入 `asmbb` 根目录执行：

```powershell
npm install
npm run build:styles
```

`clessc` 只用于旧的 `www/templates/*/compile_styles.sh`，该入口现在作为 legacy 兼容方式保留。

### musl_sqlite/build 需要联网

脚本可能下载 musl、SQLite、SQLeet 或 SQLite3MC 源码。如果构建机不能联网，需要提前把源码包放入：

```text
asmbb/musl_sqlite/
```

脚本会优先使用本地已有的：

- `musl*.tar.gz`
- `sqlite3.c`
- `sqlite*.zip`
- `sqlite*.tar.gz`

### 发布包里的 engine 不是最新

`install/create_release.sh` 不会自动编译主程序，只会复制已有的：

```text
asmbb/www/engine
```

发布前必须先重新构建主程序。

## 最小验证命令清单

在 WSL 中：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git
export lib=/mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/FreshLibDev/freshlib

which fasm || true
which gcc
gcc -m32 --version
which rsync
which node
which npm
ls "$lib/freshlib.inc"
ls asmbb/source/engine.asm
```

这些检查通过后，再进行主程序构建、运行库构建和发布包打包。

Windows 原生 PowerShell 可直接验证现代样式构建：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm install
npm run build:styles
```

成功时应输出：

```text
Less files: 103
Linked less files: 53
Real less files: 50
CSS compiled: 103
Failed: 0
```

## 手动提交

本文档新增后可手动提交：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
git add docs/WINDOWS11_BUILD_ENV_CN.md
git commit -m "Add Windows 11 build environment guide"
git push
```

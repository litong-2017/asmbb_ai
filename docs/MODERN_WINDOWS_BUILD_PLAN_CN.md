# AsmBB 现代化 Windows 兼容构建实施方案

本文档给出 `asmbb` 项目现代化构建改造方案，目标是让主题样式构建和发布流程兼容 Windows 11、WSL/Linux，并逐步替换旧的 `clessc` + shell 脚本流程。

## 目标

改造目标：

- 在 Windows 11 PowerShell 中可以执行主题样式构建。
- 在 WSL/Linux 中可以执行主题样式构建和发布包打包。
- 使用 Node.js 生态中的 `lessc` 替代旧的 `clessc`。
- 保留旧 shell 脚本作为 legacy 兼容入口，避免一次性破坏原发布流程。
- 解决 Windows checkout 下 Fossil/Git 符号链接退化成普通文本文件的问题。
- 明确验证标准，确保最终所有主题 CSS 都能稳定生成。

不在本阶段处理：

- 不改造 FASM/Fresh IDE 主程序构建链。
- 不改变 AsmBB 运行时目录结构。
- 不把 `FreshLibDev/freshlib` 合并进 `asmbb` 仓库。
- 不重写 `musl_sqlite/build`。

## 当前问题

### 1. clessc 不是现代通用工具

现有主题脚本位于各主题目录：

```text
www/templates/*/compile_styles.sh
```

脚本调用：

```sh
clessc "$file" -o "${file%.*}.css"
```

现代环境更常见的是 Node.js 版 `lessc`。它的标准用法是：

```sh
lessc input.less output.css
```

两者参数不完全一致，不能直接把命令名从 `clessc` 改成 `lessc`。

### 2. Windows 下存在伪 symlink 文件

当前项目中共有 103 个 `.less` 文件。其中不少文件内容只有一行路径，例如：

```text
../Wasp/chat.less
../mobile/posts.less
```

这类文件在 Linux/Fossil 环境中很可能原本是符号链接；在当前 Windows checkout 下变成普通文本文件。直接交给 `lessc` 会报语法错误。

示例：

```text
www/templates/Light/chat.less
```

内容：

```text
../Wasp/chat.less
```

现代构建脚本必须识别这种文件，把它解析到真实目标 Less 文件，再把输出 CSS 写回当前主题目录。

### 3. Urban Sunrise 主题存在旧语法

`Urban Sunrise` 中存在 Node 版 `lessc` 不兼容语法：

```less
input^[type=text^]
input^[type="text"^]
```

应改为标准 CSS 属性选择器：

```less
input[type=text]
input[type="text"]
```

同时存在 Less 4 数学表达式兼容问题：

```less
height: @buttonHeight + @margin/2;
height: @buttonHeight+5px;
top: @buttonHeight+4px;
```

应改为显式表达式：

```less
height: (@buttonHeight + (@margin / 2));
height: (@buttonHeight + 5px);
top: (@buttonHeight + 4px);
```

## 技术路线

采用 Node.js 脚本统一构建主题样式。

新增文件：

```text
package.json
package-lock.json
scripts/build-styles.mjs
```

建议 npm 脚本：

```json
{
  "scripts": {
    "build:styles": "node scripts/build-styles.mjs"
  },
  "devDependencies": {
    "less": "^4.2.0"
  }
}
```

统一执行方式：

Windows PowerShell：

```powershell
npm install
npm run build:styles
```

WSL/Linux：

```sh
npm ci
npm run build:styles
```

## 构建脚本设计

`scripts/build-styles.mjs` 负责：

1. 扫描 `www/templates` 下所有 `.less` 文件。
2. 跳过非 Less 入口文件，例如 `skin_variables.lsi`。
3. 读取每个 `.less` 文件内容。
4. 如果内容匹配一行相对路径，例如 `../Wasp/chat.less`，则将其视为链接占位文件。
5. 递归解析链接占位文件，直到找到真实 Less 内容。
6. 调用 Less 编译 API 或 `lessc` 编译真实源文件。
7. 将 CSS 输出到原 `.less` 文件对应位置。
8. 输出统计信息和失败明细。

### 链接占位文件规则

判断规则：

```text
文件内容 trim 后匹配：^\.\./.*\.less$
```

示例：

```text
Light/chat.less -> ../Wasp/chat.less
```

编译行为：

```text
输入源：Wasp/chat.less
输出文件：Light/chat.css
```

再例如：

```text
MoLight/posts.less -> ../mobile/posts.less
mobile/posts.less 是真实 Less 文件
```

编译行为：

```text
输入源：mobile/posts.less
输出文件：MoLight/posts.css
```

脚本需要防止循环引用：

```text
A.less -> B.less
B.less -> A.less
```

遇到循环时应报错并中止。

### 输出统计

构建结束时输出：

```text
Less files: 103
Linked less files: 53
Real less files: 50
CSS compiled: 103
Failed: 0
```

失败时输出：

```text
source less:
resolved less:
output css:
error:
```

## Less 语法迁移

### 必改文件

```text
www/templates/Urban Sunrise/common.less
www/templates/Urban Sunrise/login.less
```

### 选择器修正

把：

```less
input^[type=text^]
input^[type=search^]
input^[type=email^]
input^[type=password^]
input^[type=number^]
input^[type=checkbox^]
input^[type=radio^]
input^[type="text"^]
input^[type="password"^]
input^[type="email"^]
```

改为：

```less
input[type=text]
input[type=search]
input[type=email]
input[type=password]
input[type=number]
input[type=checkbox]
input[type=radio]
input[type="text"]
input[type="password"]
input[type="email"]
```

### 数学表达式修正

重点检查：

```text
@buttonHeight +
@buttonHeight+
@margin/
```

示例改法：

```less
height: @buttonHeight + @margin/2;
```

改为：

```less
height: (@buttonHeight + (@margin / 2));
```

```less
height: @buttonHeight+5px;
```

改为：

```less
height: (@buttonHeight + 5px);
```

```less
top: @buttonHeight+4px;
```

改为：

```less
top: (@buttonHeight + 4px);
```

## 发布脚本改造

当前 `install/create_release.sh` 会逐个进入主题目录执行：

```sh
./compile_styles.sh
```

改造后建议替换为：

```sh
pushd ..
npm ci
npm run build:styles
popd
```

如果希望兼容已安装依赖但没有 lockfile 的开发环境，可写成：

```sh
pushd ..
if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi
npm run build:styles
popd
```

发布脚本仍继续负责：

- 构建 `musl_sqlite` 运行库。
- 复制 `www/engine`。
- 复制 `www/images`。
- 复制 `www/templates`。
- 打包 `asmbb.tar.gz`。

注意：`create_release.sh` 仍不负责从 `source/engine.asm` 编译 `www/engine`。主程序构建仍需先完成。

## Legacy 兼容策略

暂时保留：

```text
www/templates/*/compile_styles.sh
```

但文档中标注为 legacy。

保留原因：

- 原项目维护者可能仍使用旧 Linux 环境。
- 可用于对比旧 `clessc` 输出。
- 降低一次性改造风险。

后续稳定后再决定是否删除旧脚本。

## Windows 兼容要求

现代构建要求 Windows 11 安装：

- Node.js 20 LTS 或更新版本。
- npm。
- Git for Windows。
- PowerShell 7 可选，但 Windows PowerShell 也应可用。

Windows 下执行：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm install
npm run build:styles
```

路径处理要求：

- 使用 Node.js `path` API。
- 不在脚本中硬编码 `/` 或 `\`。
- 对 `Urban Sunrise` 这种带空格目录必须正常处理。
- 不依赖 Bash、`find`、`sed`、`awk`。

## WSL/Linux 兼容要求

WSL/Linux 下执行：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb
npm ci
npm run build:styles
```

发布包仍建议在 WSL/Linux 下执行：

```sh
cd install
./create_release.sh
```

原因：

- `musl_sqlite/build` 依赖 Linux 工具链。
- 发布包目标是 Linux 运行环境。
- `libsqlite3.so` 和 `ld-musl-i386.so` 是 Linux 动态库。

## 验证方案

### 1. 样式构建验证

执行：

```powershell
npm run build:styles
```

必须满足：

- 所有 103 个 `.less` 入口都生成对应 `.css`。
- 构建脚本退出码为 0。
- 没有 `ParseError`、`SyntaxError`、循环链接错误。

### 2. Git 变更检查

执行：

```powershell
git status --short
```

预期变更包括：

```text
package.json
package-lock.json
scripts/build-styles.mjs
www/templates/**/*.css
www/templates/Urban Sunrise/common.less
www/templates/Urban Sunrise/login.less
install/create_release.sh
docs/*.md
```

如果 CSS 已经在仓库中存在，需确认变更是构建结果而不是路径解析错误。

### 3. 主题覆盖验证

至少确认以下主题均有 CSS 输出：

- `Wasp`
- `Light`
- `mobile`
- `MoLight`
- `Urban Sunrise`
- `NoCSS`

### 4. 发布脚本验证

在 WSL/Linux 中执行：

```sh
cd install
./create_release.sh
```

必须生成：

```text
install/asmbb.tar.gz
install/unpack.tar.gz
```

并确认发布包中包含：

```text
engine
libsqlite3.so
ld-musl-i386.so
templates/
images/
```

## 分阶段实施计划

### 阶段 1：构建脚本落地

新增：

```text
package.json
scripts/build-styles.mjs
```

实现：

- 扫描 Less 文件。
- 识别链接占位文件。
- 递归解析真实源文件。
- 调用 Less 编译。
- 输出统计。

验收：

```powershell
npm run build:styles
```

至少能编译除 `Urban Sunrise/common.less` 和 `Urban Sunrise/login.less` 外的真实 Less 文件，并能正确报告失败原因。

### 阶段 2：Less 语法迁移

修改：

```text
www/templates/Urban Sunrise/common.less
www/templates/Urban Sunrise/login.less
```

完成：

- 去除 `^` 选择器转义。
- 修正 Less 4 数学表达式。

验收：

```powershell
npm run build:styles
```

输出：

```text
Failed: 0
```

### 阶段 3：发布脚本接入

修改：

```text
install/create_release.sh
```

替换旧主题样式编译流程为：

```sh
npm ci
npm run build:styles
```

验收：

```sh
cd install
./create_release.sh
```

发布包正常生成。

### 阶段 4：文档更新

更新：

```text
docs/BUILD_RELEASE_CN.md
docs/WINDOWS11_BUILD_ENV_CN.md
```

完成：

- 将 `clessc` 标为 legacy。
- 将 Node.js、npm、Less npm package 标为现代样式构建依赖。
- 增加 Windows PowerShell 构建命令。
- 增加 WSL/Linux 发布命令。

### 阶段 5：输出差异审查

检查 CSS 差异：

```powershell
git diff -- www/templates
```

重点关注：

- `Urban Sunrise` 视觉相关 CSS。
- 链接占位文件对应主题是否生成了正确 CSS。
- CSS 中路径是否保持原样，例如 `[special:skin]`、图片路径、字体路径。

## 风险与缓解

### 风险 1：新 lessc 输出与旧 clessc 不完全一致

缓解：

- 保留旧脚本。
- 对比改造前后 CSS diff。
- 优先检查 `Urban Sunrise` 主题。

### 风险 2：伪 symlink 解析错误

缓解：

- 构建脚本输出 `source less` 和 `resolved less`。
- 对链接链路做循环检测。
- 对不存在的目标文件立即报错。

### 风险 3：Windows 路径带空格

缓解：

- 使用 Node.js `path.resolve`、`path.dirname`、`path.join`。
- 不拼接 shell 命令。
- 用 Less JS API，而不是字符串命令行。

### 风险 4：发布机无网络

缓解：

- 提交 `package-lock.json`。
- 发布机使用 `npm ci`。
- 必要时在内网缓存 npm 包。

## 最终推荐命令

Windows 11 样式构建：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
npm install
npm run build:styles
```

WSL/Linux 样式构建：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb
npm ci
npm run build:styles
```

WSL/Linux 发布：

```sh
cd /mnt/d/_LT/_data/1_otherdata/0_code_space/2_asm/0_ai/0_git/asmbb/install
./create_release.sh
```

## 手动提交

本方案文档新增后可手动提交：

```powershell
cd D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\asmbb
git add docs/MODERN_WINDOWS_BUILD_PLAN_CN.md
git commit -m "Add modern Windows-compatible build plan"
git push
```


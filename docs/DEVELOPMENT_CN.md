# AsmBB 中文开发文档

本文档面向维护和二次开发 `asmbb` 项目的开发者。当前工作区中，`asmbb` 与 `FreshLibDev` 是并列目录，`asmbb` 的核心源码依赖 `FreshLibDev\freshlib`。

## 项目概览

AsmBB 是一个用 Flat Assembler（FASM）编写的轻量级 Web 论坛引擎，运行方式是 FastCGI 应用。项目使用 SQLite 兼容接口作为后端存储，发布包中通常会携带用 musl 构建的 `libsqlite3.so` 和 `ld-musl-i386.so`，以减少服务器侧依赖。

主要运行目标是 x86 / x86-64 Linux 服务器，Web 服务器需要支持 FastCGI。README 中提到的可用 Web 服务器包括 Nginx、Apache、Lighttpd、Hiawatha 和 RWASA。

## 目录结构

```text
asmbb/
  README.md                 项目说明
  License.txt               EUPL-1.1 许可证
  source/                   汇编源码、SQL 脚本、项目文件
  www/                      运行时 Web 资源、模板、主题、图片
  musl_sqlite/              musl + SQLite/SQLeet/SQLite3MC 构建脚本
  install/                  安装说明、发布包打包脚本、示例配置
  docs/                     本项目补充开发文档

FreshLibDev/
  freshlib/                 asmbb 的 FreshLib 外部依赖
```

## FreshLib 依赖

`asmbb/source/engine.asm` 是主入口文件，开头直接包含 FreshLib：

```asm
include "%lib%/freshlib.inc"
...
include "%lib%/freshlib.asm"
include "%lib%/data/bbcode.asm"
include "%lib%/data/minimag.asm"
```

因此构建 AsmBB 时必须让 FASM/Fresh IDE 能解析 `%lib%`，并让它指向：

```text
..\FreshLibDev\freshlib
```

在当前工作区的绝对路径是：

```text
D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib
```

FreshLib 提供的关键能力包括：

- `macros/`：FASM/FreshLib 宏，包含过程、调用、二进制类型、平台抽象等基础能力。
- `equates/`：平台常量、系统调用、库接口常量。
- `system/`：文件、进程、线程、异常处理、时间、内存等系统层封装。
- `data/`：字符串、数组、哈希、编码、Markdown、BBCode、MiniMag 等数据处理代码。
- `imports/`：Linux/Win32 外部库导入定义。
- `simpledebug/`：调试输出支持。

注意：`FreshLibDev\freshlib` 目前是外部源码依赖，不在 `asmbb` 目录内。提交 `asmbb` 仓库时不要把整个 `FreshLibDev` 复制进来，建议在文档和构建脚本中固定依赖路径或后续改为 Git submodule / subtree。

## 核心入口与模块

主入口：

- `source/engine.asm`：程序入口、FreshLib 初始化、SQLite 初始化、数据库打开/创建、FastCGI 监听、SSE 线程启动和退出清理。

`engine.asm` 通过 `include` 聚合业务模块：

- `fcgi.asm`：FastCGI 通信层。
- `http.asm`：HTTP 请求/响应处理。
- `commands.asm`：命令分发和页面动作入口。
- `render2.asm`：模板渲染与输出。
- `sqlite3.asm`：SQLite 辅助封装。
- `accounts.asm`：注册、登录、会话、邮件激活、密码重置。
- `threadlist.asm`、`showthread.asm`、`edit.asm`、`delete.asm`：帖子列表、主题展示、编辑和删除。
- `search.asm`：搜索。
- `settings.asm`：论坛配置。
- `users_online.asm`、`userslist.asm`、`userinfo.asm`：用户在线状态、用户列表和用户资料。
- `attachments.asm`：附件处理。
- `chat.asm`、`realtime.asm`、`sse_service.asm`：聊天、实时事件和 Server-Sent Events。
- `atomfeed.asm`：Atom feed 输出。
- `encryption.asm`：数据库加密相关处理。
- `votes.asm`、`ignore.asm`、`history.asm`：投票、忽略列表和历史记录。

## 数据库与 SQL

数据库文件默认位于运行目录：

```text
./board.sqlite
```

首次启动时，`engine.asm` 中的 `OpenOrCreate` 会使用 `source/create.sql` 初始化数据库结构。

重要 SQL 文件：

- `source/create.sql`：初始 schema。
- `source/migration*.sql`：迁移脚本。
- `source/rebuild*.sql`：重建索引、标签、触发器、用户等维护脚本。
- `source/search.sql`、`source/search_cnt.sql`、`source/newfts.sql`：搜索与 FTS。
- `source/messages_en.sql`、`source/messages_bg.sql`：多语言消息。
- `source/phpbb.sql`、`source/phpbb_pm.sql`：phpBB 迁移相关。

开发数据库逻辑时，应同时检查对应的 `.asm` 调用和 `.sql` 文件，避免 SQL 参数顺序与 `sqliteBind*` 调用不一致。

## Web 资源与模板

`www/` 是运行时资源目录，主要包含：

- `www/templates/`：模板和主题。
- `www/images/`：图片、图标、表情资源。
- `www/robots.txt`、`www/lighttpd.conf`：运行时辅助文件。
- `www/engine`：构建后的 FastCGI 可执行文件目标位置。

模板目录中已有多个主题：

- `Wasp`
- `Light`
- `mobile`
- `MoLight`
- `Urban Sunrise`
- `NoCSS`

主题通常包含：

- `*.tpl`：HTML 模板片段。
- `*.less`：主题样式源文件。
- `*.js`：前端行为脚本。
- `_images/`：主题私有资源。
- `compile_styles.sh`：编译主题样式。

修改页面输出时，通常需要同时查看 `render2.asm`、业务模块中的渲染调用，以及对应主题的 `.tpl` 文件。

## 构建方式

原项目结构更偏向 Fresh IDE / FASM 工作流。`source/engine.fpr` 是 Fresh IDE 项目文件，主文件是：

```text
source/engine.asm
```

输出目标是：

```text
www/engine
```

构建前需要确保：

- 已安装 FASM 或 Fresh IDE。
- `%lib%` 能解析到 `FreshLibDev\freshlib`。
- `TargetOS` 选择为 `Linux`，除非明确在做 Win32/KolibriOS 适配。
- Linux 发布构建还需要 `musl_sqlite/` 生成运行时 SQLite 动态库。

在 Windows PowerShell 中调试 include 路径时，可以先临时设置：

```powershell
$env:lib = "D:\_LT\_data\1_otherdata\0_code_space\2_asm\0_ai\0_git\FreshLibDev\freshlib"
```

如果使用纯 FASM 命令行，需要确认当前 FASM 版本和构建宏支持项目中的 `%lib%`、`%TargetOS%`、`@BinaryType` 等 FreshLib/Fresh IDE 约定。更稳妥的方式是先用 Fresh IDE 打开 `source/engine.fpr` 构建。

## musl 与 SQLite 动态库

`musl_sqlite/build` 用来构建 AsmBB 发布包需要的运行库：

```sh
cd musl_sqlite
./build
```

可选参数：

```sh
./build sqlite
./build sqleet
./build sqlitemc
```

默认是 `sqlitemc`。脚本会生成：

```text
musl_sqlite/libsqlite3.so
musl_sqlite/ld-musl-i386.so
```

脚本依赖：

- `gcc`
- `tar`
- `unzip`
- `wget`
- 32 位构建支持

脚本可能会联网下载 musl、SQLite、SQLeet 或 SQLite3MultipleCiphers 源码。离线构建时，需要提前把对应源码包放到 `musl_sqlite/`。

## 发布包流程

发布脚本位于：

```text
install/create_release.sh
```

主要流程：

1. 编译多个主题的 Less 样式。
2. 进入 `musl_sqlite/` 执行 `./build sqlitemc`。
3. 复制 `www/engine` 和 `musl_sqlite/*.so` 到临时发布目录。
4. 复制 `www/images/`、`www/templates/`。
5. 复制 `.htaccess`、`lighttpd.conf`、`License.txt`、`manifest.uuid`、`install.txt`。
6. 打包生成 `install/asmbb.tar.gz`。

发布前应确认 `www/engine` 已经由最新源码构建完成，否则发布包会包含旧二进制。

## 本地运行与部署要点

运行目录需要包含：

- `engine`
- `libsqlite3.so`
- `ld-musl-i386.so`
- `templates/`
- `images/`
- Web 服务器配置文件或等价配置

首次运行会在运行目录创建：

```text
board.sqlite
```

Nginx 典型部署方式是让 `engine` 作为 systemd 服务运行，并通过 Unix socket 与 Nginx 通信。安装说明详见 `install/install.txt`。

## 开发注意事项

- 不要提交 `_FOSSIL_`，这是 Fossil checkout 本地文件。
- 修改数据库 schema 后，应同步检查初始化 SQL、迁移 SQL、重建脚本和所有绑定参数。
- 修改模板输出时，应至少检查一个桌面主题和一个移动主题。
- 修改实时功能时，应同时检查 `realtime.asm`、`sse_service.asm`、`chat.asm` 和相关前端 JS。
- 修改认证、邮件、密码、附件、数据库加密相关逻辑时，应优先做代码审查和手工回归测试。
- 发布包脚本会复制已有二进制，不会自动从 `engine.asm` 编译 `www/engine`。

## 建议的提交内容

本文件只属于 `asmbb` 仓库。提交前可检查：

```powershell
git status
git add docs/DEVELOPMENT_CN.md
git commit -m "Add Chinese development guide"
git push
```


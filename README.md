# Basin 归潮

> 一款跨平台、可扩展的下载器桌面应用，集成轻量播放器与插件生态。

[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-blue)](https://github.com/the-no-space/basin/releases)
[![License](https://img.shields.io/badge/license-Free%20%2F%20Closed--source-lightgrey)](./LICENSE)
[![Version](https://img.shields.io/badge/version-v0.0.3-green)](https://github.com/the-no-space/basin/releases/tag/v0.0.3)

---

## 中文

### 简介

**Basin 归潮** 是一款跨平台（Windows / macOS / Linux）下载器桌面应用，采用 Wails（Go 内核 + React 前端）构建。主要能力：

- **多协议下载**：HTTP 直链（多段并行、断点续传）、BitTorrent / 磁力链接（文件级选择与优先级）。
- **资源嗅探下载**：借官方 yt-dlp 插件解析网页多清晰度 / 多 P，支持登录态 cookie，嗅探即下载。
- **文件库**：下载完成后自动索引——类型识别、缩略图与视频海报、去重、自动整理规则、存储分析、全局搜索直达、文件操作可撤销。
- **查看器矩阵**：图片（EXIF）、文本 / Markdown / 代码、PDF、压缩包、音频（ID3 封面/歌词）、种子（文件树 + 一键转下载）；视频「继续观看」跨设备续播。
- **边下边播**：内置轻量播放器，下载即可预览。
- **插件系统**：exec + sidecar 双运行时的可安装扩展，官方插件含 **Player Core**（播放）、**FFmpeg Toolkit**（海报/雪碧图/探测）、**yt-dlp Engine**（嗅探下载）。
- **跨平台**：同一套体验覆盖 Windows / macOS / Linux。

### 下载与安装

从本仓库的 [Releases 页面](https://github.com/the-no-space/basin/releases) 下载对应平台的资产。

**资产命名约定**（`<ver>` 为版本号，如 `0.0.1`）：

| 平台 | 资产文件名 |
| --- | --- |
| macOS（Apple Silicon + Intel 通用包） | `Basin-<ver>-darwin-universal.tar.gz` |
| Windows | `Basin-<ver>-windows-amd64.zip` |
| Linux | `Basin-<ver>-linux-amd64.tar.gz` |

**安装步骤：**

- **macOS**：下载 `.tar.gz` 后解压，将 `Basin.app` 拖入「应用程序」文件夹。
- **Windows**：下载 `.zip` 后解压，运行其中的可执行文件。
- **Linux**：下载 `.tar.gz` 后解压，运行其中的可执行文件（按需自行创建 `.desktop` 入口）。

**macOS Gatekeeper 提示**：本应用未签名/未公证，首次打开可能被 Gatekeeper 拦截。处理方式任选其一：

- 在 Finder 中右键点击 `Basin.app`，选择「打开」，在弹窗中再次确认「打开」；或
- 在终端执行：`xattr -dr com.apple.quarantine /Applications/Basin.app`

### 更新机制

应用启动时会自动拉取本仓库 `main` 分支的 [`app.json`](./app.json) 检查更新。检测到新版本时，应用内会给出提示并跳转到对应的 Release 页面供你手动下载安装。

> 在 v0.0.x 阶段，更新方式为「通知 + 手动下载」；后续版本可能支持自动更新。

### 插件

应用通过本仓库 `main` 分支的 [`plugins.json`](./plugins.json) 获取官方插件索引。你可以在应用内的插件市场安装、更新、卸载插件；能力缺失时应用会按需引导你安装对应插件。

官方插件：

- **Player Core**：重量级播放器，比内置轻量播放器更完整的播放能力。
- **FFmpeg Toolkit**：视频海报墙 / 进度条雪碧图预览 / mkv 等格式探测。需本机装有 `ffmpeg`。
- **yt-dlp Engine**：资源嗅探与下载（多清晰度 / 多 P / 登录态）。需本机装有 `yt-dlp`。

### 许可证

本应用**免费使用但不开源**，源代码不公开。未经作者书面许可，禁止：

- 反向工程、反编译、反汇编；
- 修改、改编或创建衍生作品；
- 二次开发；
- 二次分发（含出售、出租、转授权、打包进第三方产品分发）；
- 绕过技术保护与使用限制；
- 移除或篡改版权与许可声明。

详见 [LICENSE](./LICENSE)。版权所有 © 2026 victor.lai。

> **重要**：作者保留在未来版本中将本软件从免费许可变更为付费许可的权利。后续版本的许可条款以该版本发布时适用的许可证为准；已合法获取的本版本副本继续受本版本许可证约束。

### 免责声明摘要

本软件为下载工具，不对用户下载内容负责；BT 下载的合法性由用户自负；本软件「按原样」提供，作者不承担任何保证与责任。完整内容见 [DISCLAIMER.md](./DISCLAIMER.md)。

### 仓库性质

本仓库（`the-no-space/basin`）**仅用于分发打包产物与文档，不含源代码**。源码不开源。

### 目录结构

```
.
├── LICENSE                 # 软件许可证
├── DISCLAIMER.md           # 免责声明（中英双语）
├── README.md               # 本文件
├── CHANGELOG.md            # 版本变更记录
├── app.json                # 主应用更新清单（应用启动时拉取）
├── plugins.json            # 官方插件索引
├── releases/               # （本地暂存各版本打包产物，不提交到仓库）
├── tools/                  # 发布辅助工具/脚本
└── .github/workflows/      # CI/发布工作流
```

### 联系方式

如有任何问题或建议，请联系：**victor.lai@foxmail.com**

---

## English

### Overview

**Basin 归潮** is a cross-platform (Windows / macOS / Linux) downloader desktop application built with Wails (Go core + React frontend). Key capabilities:

- **Multi-protocol downloads**: HTTP direct links (multi-segment parallel, resume) and BitTorrent / magnet links (per-file selection and priority).
- **Resource sniffing & download**: via the official yt-dlp plugin — resolve multi-quality / multi-part web sources, with login cookies; sniff then download.
- **File library**: auto-indexed once a download completes — kind detection, thumbnails & video posters, dedup, auto-organize rules, storage analysis, global search jump-to-item, undoable file ops.
- **Viewer matrix**: image (EXIF), text / Markdown / code, PDF, archives, audio (ID3 cover/lyrics), torrent (file tree + one-click to download); cross-device "continue watching" for video.
- **Stream while downloading**: built-in lightweight player for instant preview.
- **Plugin system**: installable extensions on exec + sidecar runtimes. Official plugins: **Player Core** (playback), **FFmpeg Toolkit** (posters/sprites/probing), **yt-dlp Engine** (sniffing & download).
- **Cross-platform**: a consistent experience across Windows / macOS / Linux.

### Download & Installation

Download the asset for your platform from the [Releases page](https://github.com/the-no-space/basin/releases) of this repository.

**Asset naming convention** (`<ver>` is the version, e.g. `0.0.1`):

| Platform | Asset filename |
| --- | --- |
| macOS (universal — Apple Silicon + Intel) | `Basin-<ver>-darwin-universal.tar.gz` |
| Windows | `Basin-<ver>-windows-amd64.zip` |
| Linux | `Basin-<ver>-linux-amd64.tar.gz` |

**Installation steps:**

- **macOS**: Download the `.tar.gz`, extract it, and drag `Basin.app` into the Applications folder.
- **Windows**: Download the `.zip`, extract it, and run the executable inside.
- **Linux**: Download the `.tar.gz`, extract it, and run the executable inside (create a `.desktop` entry as needed).

**macOS Gatekeeper notice**: This app is unsigned and unnotarized, so Gatekeeper may block it on first launch. To bypass, either:

- Right-click `Basin.app` in Finder, choose "Open", then confirm "Open" in the dialog; or
- Run in Terminal: `xattr -dr com.apple.quarantine /Applications/Basin.app`

### Update Mechanism

On launch, the app automatically fetches [`app.json`](./app.json) from the `main` branch of this repository to check for updates. When a newer version is detected, the app shows an in-app notice and links to the corresponding Release page for manual download.

> In the v0.0.x phase, updates are "notify + manual download"; automatic updates may be supported in later versions.

### Plugins

The app fetches the official plugin index from [`plugins.json`](./plugins.json) on the `main` branch of this repository. You can install, update, and uninstall plugins from the in-app plugin marketplace; when a capability is missing, the app guides you to install the matching plugin.

Official plugins:

- **Player Core** — a heavyweight player with fuller playback than the built-in lightweight one.
- **FFmpeg Toolkit** — video poster wall / seekbar sprite preview / mkv & other format probing. Requires `ffmpeg` on the machine.
- **yt-dlp Engine** — resource sniffing & download (multi-quality / multi-part / login). Requires `yt-dlp` on the machine.

### License

This app is **free to use but not open source**; the source code is not public. Without the Author's written permission, you may not:

- reverse engineer, decompile, or disassemble;
- modify, adapt, or create derivative works;
- perform secondary development;
- redistribute (including selling, renting, sublicensing, or bundling into third-party products for distribution);
- circumvent technical protection or usage restrictions;
- remove or tamper with copyright and license notices.

See [LICENSE](./LICENSE) for details. Copyright © 2026 victor.lai.

> **Important**: The Author reserves the right to change the Software from a free license to a paid license in future versions. The license terms of any subsequent version are governed by the license in effect at the time that version is released. A lawfully acquired copy of this version continues to be governed by this version's license.

### Disclaimer Summary

This Software is a download tool and is not responsible for downloaded content; the legality of BT downloads is the user's sole responsibility; the Software is provided "as is" without warranties of any kind, and the Author assumes no liability. Full text in [DISCLAIMER.md](./DISCLAIMER.md).

### Repository Nature

This repository (`the-no-space/basin`) is **for distributing packaged artifacts and documentation only; it does not contain source code**. The source is not open source.

### Directory Layout

```
.
├── LICENSE                 # Software license
├── DISCLAIMER.md           # Disclaimer (bilingual)
├── README.md               # This file
├── CHANGELOG.md            # Version changelog
├── app.json                # Main app update manifest (fetched by the app on launch)
├── plugins.json            # Official plugin index
├── releases/               # (local staging for release artifacts, not committed)
├── tools/                  # Release helper tools/scripts
└── .github/workflows/      # CI/release workflows
```

### Contact

For any questions or feedback: **victor.lai@foxmail.com**

---

Copyright © 2026 victor.lai <victor.lai@foxmail.com>. All rights reserved.

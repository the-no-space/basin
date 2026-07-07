# Changelog

All notable changes to Basin 归潮 are documented in this file.

---

## 中文

### v0.0.3 — 2026-07-07

「文件库与嗅探」。从下载器长成「下完之后」的一等公民，并接上资源嗅探下载。（0.0.2 为内部精致化迭代，未公开发布。）

#### 新增

- **文件库**：自动索引/扫描下载目录、类型识别（含 magic-byte 兜底）、缩略图与视频海报、三级去重、自动整理规则、存储分析、全局搜索直达库条目、文件操作可撤销（Cmd/Ctrl+Z）。
- **查看器矩阵**：图片（含 EXIF）、文本/Markdown/代码、PDF、压缩包（解压自动避让、不覆盖同名）、音频（ID3 封面/歌词）、种子/磁链（文件树 + 一键转下载）。
- **视频**：mp4 原生元数据 + 官方 ffmpeg 插件（海报墙 / 进度条雪碧图预览 / mkv 等格式探测）；「继续观看」跨设备续播。
- **资源嗅探**：官方 yt-dlp 插件解析多清晰度 / 多 P、登录态 cookie（浏览器 cookie / 原生登录窗）、嗅探即下载。（需在插件中心安装 yt-dlp 引擎插件，并本机装有 `yt-dlp` / `ffmpeg`。）
- **插件系统**：exec + sidecar 双运行时、官方 ffmpeg / yt-dlp / 播放器插件、sha256 原子安装、能力缺失时按需引导安装。
- **其它**：计划任务、通知中心、导入导出、完成后自动校验、全局代理（覆盖下载与嗅探）。

### v0.0.1 — 2026-06-30

首个公开发布版本。

#### 新增

- **跨平台桌面应用**：基于 Wails（Go 内核 + React 前端），覆盖 Windows / macOS / Linux。
- **HTTP 直链下载**：多段并行下载，断点续传。
- **BitTorrent / 磁力链接**：完整种子与磁力链接支持，文件级选择与优先级。
- **边下边播**：内置轻量播放器，下载过程中即可预览。
- **插件系统**：可安装的扩展机制，支持应用内插件市场安装 / 更新 / 卸载。
  - 首个官方插件：**Basin Player Core**（重量级播放器）。
- **EULA 门禁**：首次启动展示最终用户许可协议与免责声明，用户须明确同意后方可使用。
- **更新检查**：应用启动时自动拉取 `app.json` 检查更新，有新版本时提示并跳转 Release 页面。
- **官方插件索引**：通过 `plugins.json` 提供官方插件清单。

---

## English

### v0.0.3 — 2026-07-07

"Library & Sniffing." Grows from a downloader into a first-class "after the download" experience, and wires up resource sniffing/downloading. (0.0.2 was an internal polish iteration, not publicly released.)

#### Added

- **Library**: auto index/scan of the download dir, kind detection (with magic-byte fallback), thumbnails & video posters, 3-level dedup, auto-organize rules, storage analysis, global search jump-to-item, undoable file ops (Cmd/Ctrl+Z).
- **Viewer matrix**: image (with EXIF), text/Markdown/code, PDF, archives (extract auto-avoids, never overwrites), audio (ID3 cover/lyrics), torrent/magnet (file tree + one-click to download).
- **Video**: native mp4 metadata + official ffmpeg plugin (poster wall / seekbar sprite preview / mkv & other probing); cross-device "continue watching".
- **Resource sniffing**: official yt-dlp plugin resolves multi-quality / multi-part, login cookies (browser cookies / native login window), sniff-then-download. (Requires installing the yt-dlp engine plugin from the Plugin Center, with `yt-dlp` / `ffmpeg` present on the machine.)
- **Plugin system**: exec + sidecar runtimes, official ffmpeg / yt-dlp / player plugins, sha256 atomic install, on-demand install guidance when a capability is missing.
- **Also**: scheduled tasks, notification center, import/export, post-completion checksum, global proxy (covers downloads and sniffing).

### v0.0.1 — 2026-06-30

First public release.

#### Added

- **Cross-platform desktop app**: built with Wails (Go core + React frontend), covering Windows / macOS / Linux.
- **HTTP direct-link downloads**: multi-segment parallel downloads with resume support.
- **BitTorrent / magnet links**: full torrent and magnet support, per-file selection and priority.
- **Stream while downloading**: built-in lightweight player for in-progress preview.
- **Plugin system**: installable extension mechanism with in-app plugin marketplace for install / update / uninstall.
  - First official plugin: **Basin Player Core** (heavyweight player).
- **EULA gate**: on first launch, the End User License Agreement and Disclaimer are presented; the user must explicitly accept before use.
- **Update checking**: the app fetches `app.json` on launch to check for updates, notifying and linking to the Release page when a newer version is available.
- **Official plugin index**: official plugin catalog provided via `plugins.json`.

---

<!-- Subsequent versions will be documented below. -->

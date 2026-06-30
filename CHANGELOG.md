# Changelog

All notable changes to Basin 归潮 are documented in this file.

---

## 中文

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

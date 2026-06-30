#!/usr/bin/env bash
# tools/publish.sh — Basin 发布脚本
#
# 用法：
#   ./tools/publish.sh app v0.0.1          # 发布主 app（v0.0.1 tag）
#   ./tools/publish.sh plugin v0.0.1        # 发布 player 插件（plugin-v0.0.1 tag）
#
# 前置条件：
#   1. 产物已就位：
#      - app:   releases/Basin-<ver>-darwin-universal.tar.gz
#               releases/Basin-<ver>-windows-amd64.zip
#               （Linux 由 CI 构建，不在本地产物中）
#      - plugin: plugins/player-<ver>-<plat>.zip
#   2. 已安装 gh CLI 并登录（gh auth login）
#   3. 仓库 remote 指向 github.com/the-no-space/basin
#
# 流程（app）：
#   1. 计算 macOS/Windows 产物 sha256
#   2. 更新 app.json 中 darwin-universal / windows-amd64 的 sha256
#   3. 创建 GitHub Release（如不存在），上传 macOS/Windows 产物
#   4. Linux 产物由 CI（推 tag 触发）构建并上传到同一 Release，同时回填 linux-amd64 sha256
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

# ---- 颜色 ----
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log()  { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}⚠${NC} $*"; }
err()  { echo -e "${RED}✗${NC} $*" >&2; }

# ---- 依赖检查 ----
command -v gh >/dev/null 2>&1 || { err "需要 gh CLI（https://cli.github.com/）"; exit 1; }
gh auth status >/dev/null 2>&1 || { err "gh 未登录，请先 gh auth login"; exit 1; }

# ---- sha256 工具（macOS 用 shasum，Linux 用 sha256sum）----
sha256_func() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}

# ---- GitHub 仓库 ----
GH_REPO="the-no-space/basin"

# ================================================================
# 发布主 app
# ================================================================
publish_app() {
  local version="$1"
  # 去掉前缀 v
  local ver="${version#v}"

  log "发布主 app v${ver}"

  # 平台 → 文件名映射（本地构建的平台；Linux 由 CI 处理，不在此列）
  declare -A PLATFORMS=(
    ["darwin-universal"]="Basin-${ver}-darwin-universal.tar.gz"
    ["windows-amd64"]="Basin-${ver}-windows-amd64.zip"
  )

  # 检查产物
  local missing=0
  for plat in "${!PLATFORMS[@]}"; do
    local f="releases/${PLATFORMS[$plat]}"
    if [[ ! -f "$f" ]]; then
      warn "缺失产物: $f"
      missing=1
    fi
  done
  if [[ $missing -eq 1 ]]; then
    err "有产物缺失。请先在源码仓本地构建："
    err "  cd ../basin && make release-mac release-win"
    err "  然后把 dist/Basin-* 拷到 basin-publish/releases/"
    err "已有产物："
    ls -lh releases/ 2>/dev/null || echo "  (releases/ 目录为空)"
    exit 1
  fi

  # 计算 sha256 并更新 app.json
  log "计算 sha256..."
  local tmp_json="$(mktemp)"
  cp app.json "$tmp_json"

  for plat in "${!PLATFORMS[@]}"; do
    local f="releases/${PLATFORMS[$plat]}"
    local hash
    hash="$(sha256_func "$f")"
    log "  $plat: ${hash:0:16}... ($f)"

    # 用 python3 或 jq 更新 JSON
    if command -v jq >/dev/null 2>&1; then
      jq --arg plat "$plat" --arg hash "$hash" \
        '.platforms[$plat].sha256 = $hash' "$tmp_json" > "${tmp_json}.new"
      mv "${tmp_json}.new" "$tmp_json"
    else
      # 无 jq 时用 python3
      python3 -c "
import json, sys
with open('$tmp_json', 'r') as f:
    data = json.load(f)
data['platforms']['$plat']['sha256'] = '$hash'
with open('$tmp_json', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
"
    fi
  done

  mv "$tmp_json" app.json
  log "app.json 已更新"

  # 创建 Release
  local tag="v${ver}"
  log "创建 GitHub Release $tag..."
  if gh release view "$tag" --repo "$GH_REPO" >/dev/null 2>&1; then
    warn "Release $tag 已存在，将上传/覆盖产物"
  else
    local notes
    notes="$(jq -r '.releaseNotes.zh + "\n\n---\n\n" + .releaseNotes.en' app.json)"
    gh release create "$tag" \
      --repo "$GH_REPO" \
      --title "Basin v${ver}" \
      --notes "$notes" \
      --verify-tag
    log "Release $tag 已创建"
  fi

  # 上传产物
  for plat in "${!PLATFORMS[@]}"; do
    local f="releases/${PLATFORMS[$plat]}"
    log "上传 $f..."
    gh release upload "$tag" "$f" \
      --repo "$GH_REPO" \
      --clobber
  done

  log "主 app v${ver} 发布完成！"
  echo -e "${CYAN}Release URL: https://github.com/$GH_REPO/releases/tag/$tag${NC}"
}

# ================================================================
# 发布插件
# ================================================================
publish_plugin() {
  local version="$1"
  local ver="${version#v}"

  log "发布 player 插件 v${ver}"

  # 平台 → 文件名映射
  declare -A PLATFORMS=(
    ["darwin-arm64"]="player-${ver}-darwin-arm64.zip"
    ["darwin-amd64"]="player-${ver}-darwin-amd64.zip"
    ["windows-amd64"]="player-${ver}-windows-amd64.zip"
    ["linux-amd64"]="player-${ver}-linux-amd64.zip"
  )

  # 检查产物
  local missing=0
  for plat in "${!PLATFORMS[@]}"; do
    local f="plugins/${PLATFORMS[$plat]}"
    if [[ ! -f "$f" ]]; then
      warn "缺失产物: $f"
      missing=1
    fi
  done
  if [[ $missing -eq 1 ]]; then
    err "有插件产物缺失。请先从源码仓构建：cd desktop-plugin-release && bash build_release.sh all"
    err "已有产物："
    ls -lh plugins/ 2>/dev/null || echo "  (plugins/ 目录为空)"
    exit 1
  fi

  # 计算 sha256 并更新 plugins.json
  log "计算 sha256..."
  local tmp_json="$(mktemp)"
  cp plugins.json "$tmp_json"

  for plat in "${!PLATFORMS[@]}"; do
    local f="plugins/${PLATFORMS[$plat]}"
    local hash
    hash="$(sha256_func "$f")"
    log "  $plat: ${hash:0:16}... ($f)"

    if command -v jq >/dev/null 2>&1; then
      jq --arg plat "$plat" --arg hash "$hash" \
        '.[0].platforms[$plat].sha256 = $hash' "$tmp_json" > "${tmp_json}.new"
      mv "${tmp_json}.new" "$tmp_json"
    else
      python3 -c "
import json
with open('$tmp_json', 'r') as f:
    data = json.load(f)
data[0]['platforms']['$plat']['sha256'] = '$hash'
with open('$tmp_json', 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
"
    fi
  done

  mv "$tmp_json" plugins.json
  log "plugins.json 已更新"

  # 创建 Release
  local tag="plugin-v${ver}"
  log "创建 GitHub Release $tag..."
  if gh release view "$tag" --repo "$GH_REPO" >/dev/null 2>&1; then
    warn "Release $tag 已存在，将上传/覆盖产物"
  else
    local notes
    notes="$(jq -r '.[0].changelog' plugins.json)"
    gh release create "$tag" \
      --repo "$GH_REPO" \
      --title "Player Plugin v${ver}" \
      --notes "$notes" \
      --verify-tag
    log "Release $tag 已创建"
  fi

  # 上传产物
  for plat in "${!PLATFORMS[@]}"; do
    local f="plugins/${PLATFORMS[$plat]}"
    log "上传 $f..."
    gh release upload "$tag" "$f" \
      --repo "$GH_REPO" \
      --clobber
  done

  log "插件 v${ver} 发布完成！"
  echo -e "${CYAN}Release URL: https://github.com/$GH_REPO/releases/tag/$tag${NC}"
}

# ================================================================
# 主入口
# ================================================================
usage() {
  cat <<EOF
用法: $0 <app|plugin> <version>

示例:
  $0 app v0.0.1          发布主 app v0.0.1
  $0 app 0.0.1           同上（v 前缀可选）
  $0 plugin v0.0.1       发布 player 插件 v0.0.1

前置:
  - 产物已就位（releases/ 或 plugins/）
  - gh CLI 已安装并登录
EOF
}

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

case "$1" in
  app)     publish_app "$2" ;;
  plugin)  publish_plugin "$2" ;;
  *)
    err "未知类型: $1（应为 app 或 plugin）"
    usage
    exit 1
    ;;
esac

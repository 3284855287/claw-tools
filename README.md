# claw-tools

macOS 上的自用小工具集：OCR 截图取字、桌面热键控制、微信消息监听。

## 目录结构

```
tools/
  ocr.swift          # 命令行 OCR：截图 → 识别文字（调用系统 Vision 框架）
desktop-control/
  desktop_control.py # 桌面窗口/热键控制
  DesktopHotkey/     # 快捷键相关实现
wechat-bot/
  watcher.py         # 微信窗口监听
  monitor_py.py      # 消息监控
  findwin.py         # 窗口查找
  wxctl.py           # 微信控制封装
```

## 环境要求

- macOS 15+
- Swift（随 Xcode Command Line Tools 提供）
- Python 3

## 编译 OCR 工具

```bash
swiftc tools/ocr.swift -o tools/ocr
```

## 说明

本仓库仅存放脚本与源码；编译产物、个人文件、凭据均不进版本库（见 `.gitignore`）。

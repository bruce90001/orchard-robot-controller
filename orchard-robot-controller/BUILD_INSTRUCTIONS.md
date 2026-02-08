# 构建 APK 安装包指南

由于本地环境未安装 Flutter，有以下几种方式获取 APK：

## 方案 1：使用 Codemagic（推荐）

1. 将项目上传到 GitHub
2. 访问 https://codemagic.io
3. 连接 GitHub 仓库
4. 选择 Flutter 项目
5. 点击 "Start new build"
6. 等待构建完成（约 5-10 分钟）
7. 下载生成的 APK

## 方案 2：使用 GitHub Actions

项目已包含 `.github/workflows/build.yml` 配置文件。

1. 将代码推送到 GitHub
2. GitHub Actions 会自动构建
3. 在 Actions 标签页下载 APK

## 方案 3：本地安装 Flutter 构建

### Windows 系统：

1. 下载 Flutter SDK：
   https://docs.flutter.dev/get-started/install/windows

2. 解压到 C:\flutter

3. 添加环境变量：
   - 系统变量 Path 添加：C:\flutter\bin

4. 安装 Android Studio：
   https://developer.android.com/studio

5. 在项目目录运行：
   ```cmd
   flutter pub get
   flutter build apk --release
   ```

6. APK 位置：
   build\app\outputs\flutter-apk\app-release.apk

## 方案 4：使用 Docker 构建

```bash
docker run --rm -v ${PWD}:/project -w /project cirrusci/flutter:stable flutter build apk --release
```

## 快速测试（无需构建）

如果只是想快速测试，可以：

1. 安装 Flutter
2. 连接安卓设备（开启 USB 调试）
3. 运行：`flutter run`

这样可以直接在设备上运行，无需构建 APK。

---

**推荐使用方案 1 或方案 2**，无需本地安装任何工具，在线自动构建。

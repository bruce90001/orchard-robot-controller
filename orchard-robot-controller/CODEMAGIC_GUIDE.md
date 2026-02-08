# Codemagic 在线构建指南

## 📋 准备工作

项目已经完全配置好，包含：
- ✅ Flutter 项目结构
- ✅ Android 配置文件
- ✅ Codemagic 配置文件 (codemagic.yaml)
- ✅ 所有依赖项

## 🚀 构建步骤

### 第 1 步：上传到 GitHub

1. 访问 https://github.com
2. 点击右上角 "+" → "New repository"
3. 仓库名称：`orchard-robot-controller`
4. 选择 "Public" 或 "Private"
5. 点击 "Create repository"

6. 在本地项目目录打开命令提示符，运行：

```cmd
git init
git add .
git commit -m "Initial commit: Orchard Robot Controller"
git branch -M main
git remote add origin https://github.com/你的用户名/orchard-robot-controller.git
git push -u origin main
```

### 第 2 步：配置 Codemagic

1. 访问 https://codemagic.io/signup
2. 点击 "Sign up with GitHub"（用 GitHub 账号登录）
3. 授权 Codemagic 访问你的仓库

### 第 3 步：添加项目

1. 在 Codemagic 控制台，点击 "Add application"
2. 选择 "GitHub"
3. 找到并选择 `orchard-robot-controller` 仓库
4. 点击 "Finish: Add application"

### 第 4 步：开始构建

1. Codemagic 会自动检测到 `codemagic.yaml` 配置
2. 点击 "Start new build"
3. 选择 "android-workflow"
4. 点击 "Start new build"

### 第 5 步：等待构建完成

- 构建时间：约 5-10 分钟
- 你可以实时查看构建日志
- 构建过程：
  - ✓ 设置 Flutter 环境
  - ✓ 获取依赖包
  - ✓ 构建 APK

### 第 6 步：下载 APK

1. 构建成功后，在 "Artifacts" 部分
2. 下载 `app-release.apk`（通用版本，约 20-30 MB）
3. 或下载特定架构版本：
   - `app-arm64-v8a-release.apk`（64位，推荐）
   - `app-armeabi-v7a-release.apk`（32位）

### 第 7 步：安装到手机

1. 将 APK 传输到手机（通过 USB、微信、邮件等）
2. 在手机上打开 APK 文件
3. 允许"安装未知来源应用"
4. 点击"安装"

## 🎯 快速命令（如果你已有 Git）

```cmd
cd 项目目录
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/orchard-robot-controller.git
git push -u origin main
```

## ⚠️ 常见问题

### Q: 没有 Git？
A: 下载安装：https://git-scm.com/download/win

### Q: 构建失败？
A: 检查 Codemagic 日志，通常是依赖问题。项目已配置好，应该不会失败。

### Q: APK 太大？
A: 下载特定架构版本（arm64-v8a），体积更小。

### Q: 不想用 GitHub？
A: Codemagic 也支持 GitLab 和 Bitbucket。

## 📱 安装后配置

首次运行应用时：
1. 允许网络权限
2. 在设置中配置 ROS 服务器地址（默认：ws://192.168.1.100:9090）
3. 确保手机和机器人在同一网络

## 🔄 更新应用

修改代码后：
```cmd
git add .
git commit -m "更新说明"
git push
```

然后在 Codemagic 重新构建即可。

---

**需要帮助？** 如果遇到问题，可以查看 Codemagic 文档：
https://docs.codemagic.io/flutter-configuration/flutter-projects/

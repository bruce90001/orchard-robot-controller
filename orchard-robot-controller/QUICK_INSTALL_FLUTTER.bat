@echo off
echo ========================================
echo Flutter 快速安装脚本 (Windows)
echo ========================================
echo.

echo 步骤 1: 下载 Flutter SDK
echo 请访问: https://docs.flutter.dev/get-started/install/windows
echo 下载 flutter_windows_3.16.0-stable.zip
echo.
pause

echo 步骤 2: 解压到 C:\flutter
echo 将下载的 zip 文件解压到 C:\flutter
echo.
pause

echo 步骤 3: 添加环境变量
echo 正在添加 Flutter 到系统 PATH...
setx PATH "%PATH%;C:\flutter\bin"
echo.

echo 步骤 4: 验证安装
echo 请关闭并重新打开命令提示符，然后运行:
echo flutter doctor
echo.

echo 步骤 5: 构建 APK
echo 在项目目录运行:
echo flutter pub get
echo flutter build apk --release
echo.

echo APK 将生成在:
echo build\app\outputs\flutter-apk\app-release.apk
echo.
pause

@echo off
echo ========================================
echo 构建果园机器人控制器 APK
echo ========================================
echo.

echo 检查 Flutter 是否已安装...
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到 Flutter！
    echo 请先运行 QUICK_INSTALL_FLUTTER.bat 安装 Flutter
    pause
    exit /b 1
)

echo [OK] Flutter 已安装
echo.

echo 步骤 1/3: 获取依赖包...
call flutter pub get
if %errorlevel% neq 0 (
    echo [错误] 依赖包获取失败
    pause
    exit /b 1
)

echo.
echo 步骤 2/3: 清理旧构建...
call flutter clean

echo.
echo 步骤 3/3: 构建 Release APK...
call flutter build apk --release
if %errorlevel% neq 0 (
    echo [错误] APK 构建失败
    pause
    exit /b 1
)

echo.
echo ========================================
echo 构建成功！
echo ========================================
echo.
echo APK 位置:
echo %cd%\build\app\outputs\flutter-apk\app-release.apk
echo.
echo 文件大小:
dir build\app\outputs\flutter-apk\app-release.apk | find "app-release.apk"
echo.
echo 现在可以将 APK 传输到安卓设备安装了！
echo.
pause

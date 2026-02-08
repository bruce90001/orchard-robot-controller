# 部署指南

## 开发环境搭建

### 1. 安装 Flutter
```bash
# 下载 Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable

# 添加到环境变量
export PATH="$PATH:`pwd`/flutter/bin"

# 检查环境
flutter doctor
```

### 2. 安装 Android Studio
- 下载并安装 Android Studio
- 安装 Android SDK (API 21+)
- 安装 Flutter 和 Dart 插件

### 3. 配置项目
```bash
# 克隆项目
git clone <repository_url>
cd orchard_robot_controller

# 安装依赖
flutter pub get

# 检查设备
flutter devices
```

## 构建 APK

### Debug 版本
```bash
flutter build apk --debug
```

### Release 版本
```bash
flutter build apk --release
```

生成的 APK 位于：`build/app/outputs/flutter-apk/app-release.apk`

## 安装到设备

### 通过 USB
```bash
# 连接设备并启用 USB 调试
flutter install

# 或直接运行
flutter run
```

### 通过 ADB
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

## ROS 端配置

### 1. 安装 rosbridge_server
```bash
sudo apt-get install ros-noetic-rosbridge-server
```

### 2. 启动 rosbridge
```bash
roslaunch rosbridge_server rosbridge_websocket.launch
```

### 3. 配置视频流
```bash
# 安装 web_video_server
sudo apt-get install ros-noetic-web-video-server

# 启动视频服务器
rosrun web_video_server web_video_server
```

### 4. 完整启动脚本
创建 `launch/orchard_robot.launch`:
```xml
<launch>
  <!-- ROS Bridge -->
  <include file="$(find rosbridge_server)/launch/rosbridge_websocket.launch">
    <arg name="port" value="9090"/>
  </include>

  <!-- Web Video Server -->
  <node name="web_video_server" pkg="web_video_server" type="web_video_server">
    <param name="port" value="8080"/>
  </node>

  <!-- 其他节点 -->
  <node name="robot_state_publisher" pkg="robot_state_publisher" type="robot_state_publisher"/>
</launch>
```

启动：
```bash
roslaunch orchard_robot orchard_robot.launch
```

## 网络配置

### 1. 确保设备在同一网络
- 机器人：192.168.1.100
- 遥控器：192.168.1.xxx

### 2. 防火墙设置
```bash
# 开放端口
sudo ufw allow 9090/tcp  # rosbridge
sudo ufw allow 8080/tcp  # video stream
```

### 3. 测试连接
```bash
# 测试 rosbridge
wscat -c ws://192.168.1.100:9090

# 测试视频流
curl http://192.168.1.100:8080/stream_viewer?topic=/camera/left/image_raw
```

## 性能优化

### 1. 视频流优化
- 降低分辨率：640x480
- 调整帧率：15-20 FPS
- 使用 MJPEG 压缩

### 2. 网络优化
- 使用 5GHz WiFi
- 减少话题发布频率
- 启用消息压缩

### 3. 应用优化
- 启用硬件加速
- 优化渲染性能
- 减少不必要的重绘

## 故障排查

### 连接失败
1. 检查网络连接
2. 验证 IP 地址
3. 确认 rosbridge 运行
4. 检查防火墙设置

### 视频无法显示
1. 确认相机话题发布
2. 检查视频服务器状态
3. 验证视频流 URL
4. 查看应用日志

### 控制延迟
1. 检查网络延迟
2. 优化话题频率
3. 减少数据传输量
4. 使用有线连接

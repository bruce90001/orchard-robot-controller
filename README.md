# 果园机器人上位机 Android 应用

## 项目概述
果园机器人遥控器上位机软件，运行在安卓设备上，用于监控和控制果园作业机器人。

## 主要功能
- 双相机实时视频流显示
- 轮胎压力监控（4个轮胎）
- 地图导航显示
- 机器人状态监控（坐标、电池、模式）
- 路径规划和编辑
- 定位模式切换
- 功能控制开关

## 技术栈
- Flutter 3.x
- ROS Bridge WebSocket 通信
- MJPEG/WebRTC 视频流
- 自定义地图渲染

## 开发环境要求
- Flutter SDK 3.0+
- Android Studio / VS Code
- Android SDK (API 21+)
- Dart 3.0+

## 项目结构
```
orchard_robot_controller/
├── lib/
│   ├── main.dart                 # 应用入口
│   ├── screens/
│   │   └── main_control_screen.dart  # 主控制界面
│   ├── widgets/
│   │   ├── camera_view.dart      # 相机视图组件
│   │   ├── tire_pressure_panel.dart  # 轮胎压力面板
│   │   ├── map_view.dart         # 地图显示组件
│   │   └── control_buttons.dart  # 控制按钮组件
│   ├── services/
│   │   ├── ros_service.dart      # ROS 通信服务
│   │   └── video_stream_service.dart  # 视频流服务
│   └── models/
│       ├── robot_state.dart      # 机器人状态模型
│       └── tire_data.dart        # 轮胎数据模型
├── android/                      # Android 原生配置
├── assets/                       # 资源文件
└── pubspec.yaml                  # 依赖配置
```

## 安装和运行
```bash
# 安装依赖
flutter pub get

# 运行应用
flutter run

# 构建 APK
flutter build apk --release
```

## ROS 通信配置
需要配置 rosbridge_server 地址和端口，默认：
- WebSocket: ws://192.168.1.xxx:9090
- 视频流: http://192.168.1.xxx:8080

## 开发计划
- [x] 项目初始化
- [ ] UI 界面实现
- [ ] ROS 通信集成
- [ ] 视频流集成
- [ ] 地图渲染
- [ ] 控制逻辑
- [ ] 测试和优化

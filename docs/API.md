# ROS 通信接口文档

## WebSocket 连接

默认地址：`ws://192.168.1.100:9090`

使用 rosbridge_server 进行通信。

## 订阅的话题

### 1. 机器人位置 `/odom`
- 类型：`nav_msgs/Odometry`
- 频率：10Hz
- 用途：获取机器人当前位置和姿态

```json
{
  "pose": {
    "pose": {
      "position": {"x": 0.0, "y": 0.0, "z": 0.0},
      "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}
    }
  }
}
```

### 2. 电池状态 `/battery`
- 类型：`sensor_msgs/BatteryState`
- 频率：1Hz
- 用途：监控电池电量

```json
{
  "percentage": 0.92,
  "voltage": 24.5
}
```

### 3. 轮胎压力 `/tire_pressure`
- 类型：`std_msgs/Float32MultiArray`
- 频率：1Hz
- 用途：监控8个轮胎的压力

```json
{
  "data": [56.1, 112.3, 93.3, 111.7, 85.6, 85.6, 116.2, 80.3]
}
```
前4个为左侧轮胎，后4个为右侧轮胎

### 4. 相机图像流
- 左侧相机：`http://192.168.1.100:8080/stream?topic=/camera/left/image_raw`
- 右侧相机：`http://192.168.1.100:8080/stream?topic=/camera/right/image_raw`

## 发布的话题

### 1. 速度控制 `/cmd_vel`
- 类型：`geometry_msgs/Twist`
- 用途：控制机器人移动

```json
{
  "linear": {"x": 0.5, "y": 0.0, "z": 0.0},
  "angular": {"x": 0.0, "y": 0.0, "z": 0.3}
}
```

### 2. 导航目标 `/move_base_simple/goal`
- 类型：`geometry_msgs/PoseStamped`
- 用途：发送导航目标点

```json
{
  "header": {"frame_id": "map"},
  "pose": {
    "position": {"x": 10.0, "y": 5.0, "z": 0.0},
    "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}
  }
}
```

### 3. 路径规划 `/path`
- 类型：`nav_msgs/Path`
- 用途：发送预设路径

## 服务调用

### 1. 清除地图 `/clear_costmaps`
- 类型：`std_srvs/Empty`
- 用途：清除代价地图

### 2. 保存地图 `/save_map`
- 类型：`nav_msgs/GetMap`
- 用途：保存当前地图

## 配置参数

在应用中可配置：
- ROS Master URI
- 视频流地址
- 更新频率
- 超时时间

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class RosService extends ChangeNotifier {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  String _rosServerUrl = 'ws://192.168.1.100:9090';

  bool get isConnected => _isConnected;
  String get rosServerUrl => _rosServerUrl;

  // 机器人状态
  Map<String, dynamic> robotState = {
    'position': {'x': 0.0, 'y': 0.0, 'z': 0.0},
    'orientation': {'x': 0.0, 'y': 0.0, 'z': 0.0, 'w': 1.0},
    'battery': 92,
    'mode': 'auto',
  };

  // 轮胎压力数据
  Map<String, List<double>> tirePressure = {
    'left': [56.1, 112.3, 93.3, 111.7],
    'right': [85.6, 85.6, 116.2, 80.3],
  };

  void setRosServerUrl(String url) {
    _rosServerUrl = url;
    notifyListeners();
  }

  Future<void> connect() async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_rosServerUrl));
      
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _isConnected = false;
          notifyListeners();
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
          _isConnected = false;
          notifyListeners();
        },
      );

      _isConnected = true;
      notifyListeners();
      
      // 订阅话题
      _subscribeToTopics();
    } catch (e) {
      debugPrint('Failed to connect: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    notifyListeners();
  }

  void _subscribeToTopics() {
    // 订阅机器人位置
    _subscribe('/odom', 'nav_msgs/Odometry');
    
    // 订阅电池状态
    _subscribe('/battery', 'sensor_msgs/BatteryState');
    
    // 订阅轮胎压力
    _subscribe('/tire_pressure', 'std_msgs/Float32MultiArray');
  }

  void _subscribe(String topic, String type) {
    final message = {
      'op': 'subscribe',
      'topic': topic,
      'type': type,
    };
    _send(message);
  }

  void _send(Map<String, dynamic> message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(jsonEncode(message));
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      
      if (data['topic'] == '/odom') {
        _handleOdometry(data['msg']);
      } else if (data['topic'] == '/battery') {
        _handleBattery(data['msg']);
      } else if (data['topic'] == '/tire_pressure') {
        _handleTirePressure(data['msg']);
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error handling message: $e');
    }
  }

  void _handleOdometry(Map<String, dynamic> msg) {
    robotState['position'] = msg['pose']['pose']['position'];
    robotState['orientation'] = msg['pose']['pose']['orientation'];
  }

  void _handleBattery(Map<String, dynamic> msg) {
    robotState['battery'] = (msg['percentage'] * 100).toInt();
  }

  void _handleTirePressure(Map<String, dynamic> msg) {
    final data = List<double>.from(msg['data']);
    if (data.length >= 8) {
      tirePressure['left'] = data.sublist(0, 4);
      tirePressure['right'] = data.sublist(4, 8);
    }
  }

  // 发布控制命令
  void publishVelocity(double linear, double angular) {
    final message = {
      'op': 'publish',
      'topic': '/cmd_vel',
      'msg': {
        'linear': {'x': linear, 'y': 0.0, 'z': 0.0},
        'angular': {'x': 0.0, 'y': 0.0, 'z': angular},
      },
    };
    _send(message);
  }

  // 发送导航目标
  void sendNavigationGoal(double x, double y, double theta) {
    final message = {
      'op': 'publish',
      'topic': '/move_base_simple/goal',
      'msg': {
        'header': {
          'frame_id': 'map',
        },
        'pose': {
          'position': {'x': x, 'y': y, 'z': 0.0},
          'orientation': {
            'x': 0.0,
            'y': 0.0,
            'z': theta,
            'w': 1.0,
          },
        },
      },
    };
    _send(message);
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

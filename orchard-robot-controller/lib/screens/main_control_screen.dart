import 'package:flutter/material.dart';
import '../widgets/camera_view.dart';
import '../widgets/tire_pressure_panel.dart';
import '../widgets/map_view.dart';
import '../widgets/control_buttons.dart';
import '../widgets/status_bar.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({super.key});

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // 顶部状态栏
          const StatusBar(),
          
          // 主要内容区域
          Expanded(
            child: Row(
              children: [
                // 左侧面板
                Expanded(
                  flex: 2,
                  child: _buildLeftPanel(),
                ),
                
                // 中间地图区域
                Expanded(
                  flex: 5,
                  child: _buildMapArea(),
                ),
                
                // 右侧面板
                Expanded(
                  flex: 2,
                  child: _buildRightPanel(),
                ),
              ],
            ),
          ),
          
          // 底部控制按钮
          const ControlButtons(),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 左侧相机标题
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '左侧摄像头',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          // 左侧相机视图
          const Expanded(
            flex: 3,
            child: CameraView(cameraId: 'left'),
          ),
          
          // 左侧轮胎压力面板
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '左侧轮胎压力',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            flex: 2,
            child: TirePressurePanel(side: 'left'),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 右侧相机标题
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '右侧摄像头',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          // 右侧相机视图
          const Expanded(
            flex: 3,
            child: CameraView(cameraId: 'right'),
          ),
          
          // 右侧轮胎压力面板
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              '右侧轮胎压力',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            flex: 2,
            child: TirePressurePanel(side: 'right'),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: const MapView(),
    );
  }
}

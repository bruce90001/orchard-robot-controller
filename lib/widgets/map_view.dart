import 'package:flutter/material.dart';
import 'dart:math' as math;

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Offset robotPosition = const Offset(0.5, 0.5);
  double robotAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Stack(
        children: [
          // 地图背景
          CustomPaint(
            size: Size.infinite,
            painter: MapPainter(
              robotPosition: robotPosition,
              robotAngle: robotAngle,
            ),
          ),
          
          // 地图控制按钮
          Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                _buildMapButton(Icons.zoom_in, () {}),
                const SizedBox(height: 8),
                _buildMapButton(Icons.zoom_out, () {}),
                const SizedBox(height: 8),
                _buildMapButton(Icons.my_location, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
        color: Colors.blue,
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final Offset robotPosition;
  final double robotAngle;

  MapPainter({
    required this.robotPosition,
    required this.robotAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制网格
    _drawGrid(canvas, size);
    
    // 绘制机器人
    _drawRobot(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 0.5;

    const gridSize = 50.0;
    
    // 垂直线
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // 水平线
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  void _drawRobot(Canvas canvas, Size size) {
    final center = Offset(
      size.width * robotPosition.dx,
      size.height * robotPosition.dy,
    );

    // 绘制机器人三角形
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    const robotSize = 20.0;
    final path = Path();
    
    // 三角形顶点（指向前方）
    path.moveTo(
      center.dx + robotSize * math.cos(robotAngle),
      center.dy + robotSize * math.sin(robotAngle),
    );
    path.lineTo(
      center.dx + robotSize * math.cos(robotAngle + 2.4),
      center.dy + robotSize * math.sin(robotAngle + 2.4),
    );
    path.lineTo(
      center.dx + robotSize * math.cos(robotAngle - 2.4),
      center.dy + robotSize * math.sin(robotAngle - 2.4),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) {
    return oldDelegate.robotPosition != robotPosition ||
        oldDelegate.robotAngle != robotAngle;
  }
}

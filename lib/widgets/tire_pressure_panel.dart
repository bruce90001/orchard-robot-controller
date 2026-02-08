import 'package:flutter/material.dart';

class TirePressurePanel extends StatelessWidget {
  final String side;
  
  const TirePressurePanel({super.key, required this.side});

  @override
  Widget build(BuildContext context) {
    // 模拟轮胎压力数据
    final List<Map<String, dynamic>> tireData = side == 'left'
        ? [
            {'pressure': 56.1, 'unit': 'mBar'},
            {'pressure': 112.3, 'unit': 'mBar'},
            {'pressure': 93.3, 'unit': 'mBar'},
            {'pressure': 111.7, 'unit': 'mBar'},
          ]
        : [
            {'pressure': 85.6, 'unit': 'mBar'},
            {'pressure': 85.6, 'unit': 'mBar'},
            {'pressure': 116.2, 'unit': 'mBar'},
            {'pressure': 80.3, 'unit': 'mBar'},
          ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: tireData.length,
      itemBuilder: (context, index) {
        return _buildTireItem(
          index + 1,
          tireData[index]['pressure'],
          tireData[index]['unit'],
        );
      },
    );
  }

  Widget _buildTireItem(int tireNumber, double pressure, String unit) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // 轮胎编号按钮
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '轮胎$tireNumber',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // 压力显示
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$pressure $unit',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // 设置按钮
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

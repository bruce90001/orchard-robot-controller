import 'package:flutter/material.dart';

class ControlButtons extends StatefulWidget {
  const ControlButtons({super.key});

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  String selectedMode = 'none'; // none, semi, full
  bool functionSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 定位模式选择
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildModeButton(
                '无环境定位模式',
                'none',
                Colors.red,
              ),
              const SizedBox(width: 16),
              _buildModeButton(
                '准环境定位模式',
                'semi',
                Colors.yellow[700]!,
              ),
              const SizedBox(width: 16),
              _buildFunctionSwitch(),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // 主要控制按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMainButton(
                '导航',
                Colors.green,
                Icons.navigation,
                () {},
              ),
              const SizedBox(width: 16),
              _buildMainButton(
                '打开路径编辑',
                Colors.blue,
                Icons.edit_road,
                () {},
              ),
              const SizedBox(width: 16),
              _buildMainButton(
                '清除',
                Colors.red,
                Icons.clear,
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(String label, String mode, Color color) {
    final isSelected = selectedMode == mode;
    
    return InkWell(
      onTap: () {
        setState(() {
          selectedMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Row(
        children: [
          const Text(
            '功能控制开关',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: functionSwitch,
            onChanged: (value) {
              setState(() {
                functionSwitch = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton(
    String label,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

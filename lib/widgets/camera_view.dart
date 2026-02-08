import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  final String cameraId;
  
  const CameraView({super.key, required this.cameraId});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          // 视频流显示区域
          Center(
            child: Image.asset(
              'assets/images/camera_placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(
                      Icons.videocam_off,
                      size: 48,
                      color: Colors.white54,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 相机标识
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.cameraId == 'left' ? '左侧相机' : '右侧相机',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

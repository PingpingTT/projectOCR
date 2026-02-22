import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class DocumentCameraPage extends StatefulWidget {
  const DocumentCameraPage({super.key});

  @override
  State<DocumentCameraPage> createState() => _DocumentCameraPageState();
}

class _DocumentCameraPageState extends State<DocumentCameraPage> {
  late CameraController _controller;
  bool _ready = false;
  Rect? scanRect;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller.initialize();
    setState(() => _ready = true);
  }

  @override
  void dispose() {
    _controller.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CameraPreview(_controller),
                  ),
                  LayoutBuilder(
                    builder: (_, constraints) {
                      final width = constraints.maxWidth * 0.7;
                      final height = width / 1.6;

                      scanRect = Rect.fromCenter(
                        center: Offset(
                          constraints.maxWidth / 2,
                          constraints.maxHeight / 2,
                        ),
                        width: width,
                        height: height,
                      );

                      return CustomPaint(
                        size: constraints.biggest,
                        painter: _OverlayPainter(scanRect!),
                      );
                    },
                  ),
                ],
              ),
            ),

            /// 🔘 ปุ่มถ่ายรูป
            Container(
              width: 120,
              color: Colors.black,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _capture,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _capture() async {
    final file = await _controller.takePicture();

    final cropped = await cropImage(
      file.path,
      scanRect!,
      _controller,
    );

    if (!mounted) return;
    Navigator.pop(context, cropped);
  }
}

class _OverlayPainter extends CustomPainter {
  final Rect rect;

  _OverlayPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());

    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);

    canvas.drawRect(Offset.zero & size, bgPaint);

    final clearPaint = Paint()..blendMode = BlendMode.clear;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      clearPaint,
    );

    final borderPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      borderPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(_) => false;
}

/// ✅ Crop ที่แม่นใน landscape
Future<File> cropImage(
  String path,
  Rect rect,
  CameraController controller,
) async {
  final bytes = await File(path).readAsBytes();
  final original = img.decodeImage(bytes)!;

  final previewSize = controller.value.previewSize!;

  /// สลับแกนเพราะ landscape
  final previewWidth = previewSize.height;
  final previewHeight = previewSize.width;

  final scaleX = original.width / previewWidth;
  final scaleY = original.height / previewHeight;

  final cropX = (rect.left * scaleX).toInt();
  final cropY = (rect.top * scaleY).toInt();
  final cropW = (rect.width * scaleX).toInt();
  final cropH = (rect.height * scaleY).toInt();

  final cropped = img.copyCrop(
    original,
    x: cropX.clamp(0, original.width - 1),
    y: cropY.clamp(0, original.height - 1),
    width: cropW.clamp(1, original.width - cropX),
    height: cropH.clamp(1, original.height - cropY),
  );

  final dir = await getTemporaryDirectory();
  final file = File(
    '${dir.path}/crop_${DateTime.now().millisecondsSinceEpoch}.jpg',
  );

  await file.writeAsBytes(
    img.encodeJpg(cropped, quality: 95),
  );

  return file;
}

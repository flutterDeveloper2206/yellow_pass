import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'controller/qr_scanner_controller.dart';

class QrScannerScreen extends GetView<QrScannerController> {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onDetect,
          ),
          // Overlay
          Container(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor:  Colors.yellow,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),  Positioned(
            top: 100,
            right: 20,
            child: IconButton(
              icon: const Text('Skip',style: TextStyle( color: Colors.white)),
              onPressed: () {
                controller.skipScanner();
              },
            ),
          ),
          // Title
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Scan QR Code",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Instructions
          const Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Align QR code within the frame to scan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Overlay Shape
class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;
  final double cutOutBottomOffset;

  const QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 10.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80),
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
    this.cutOutBottomOffset = 0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final borderWidthSize = width / 2;
    final height = rect.height;
    final borderOffset = borderWidth / 2;
    final _cutOutSize = cutOutSize != null && cutOutSize < width
        ? cutOutSize
        : width - borderOffset;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - _cutOutSize / 2 + borderOffset,
      rect.top + height / 2 - _cutOutSize / 2 + borderOffset,
      _cutOutSize - borderWidth,
      _cutOutSize - borderWidth,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();

    final borderRect = RRect.fromRectAndRadius(
      cutOutRect,
      Radius.circular(borderRadius),
    );

    _drawBorder(canvas, borderRect, borderPaint);
  }

  void _drawBorder(Canvas canvas, RRect rect, Paint paint) {
    // Draw corners
    // Top left
    canvas.drawPath(
      Path()
        ..moveTo(rect.left, rect.top + borderLength)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.left + borderLength, rect.top),
      paint,
    );
    // Top right
    canvas.drawPath(
      Path()
        ..moveTo(rect.right - borderLength, rect.top)
        ..lineTo(rect.right, rect.top)
        ..lineTo(rect.right, rect.top + borderLength),
      paint,
    );
    // Bottom right
    canvas.drawPath(
      Path()
        ..moveTo(rect.right, rect.bottom - borderLength)
        ..lineTo(rect.right, rect.bottom)
        ..lineTo(rect.right - borderLength, rect.bottom),
      paint,
    );
    // Bottom left
    canvas.drawPath(
      Path()
        ..moveTo(rect.left + borderLength, rect.bottom)
        ..lineTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.bottom - borderLength),
      paint,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}

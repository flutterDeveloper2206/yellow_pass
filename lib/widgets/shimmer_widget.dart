import 'package:flutter/material.dart';

class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            color: baseColor,
            shape: widget.shapeBorder,
          ),
          child: ClipPath(
            clipper: _ShapeClipper(widget.shapeBorder),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: CustomPaint(
                painter: _ShimmerPainter(
                  progress: _controller.value,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ShapeClipper extends CustomClipper<Path> {
  final ShapeBorder shape;
  _ShapeClipper(this.shape);

  @override
  Path getClip(Size size) {
    return shape.getOuterPath(Offset.zero & size);
  }

  @override
  bool shouldReclip(_ShapeClipper oldClipper) => oldClipper.shape != shape;
}

class _ShimmerPainter extends CustomPainter {
  final double progress;
  final Color baseColor;
  final Color highlightColor;

  _ShimmerPainter({
    required this.progress,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor,
          highlightColor,
          baseColor,
        ],
        stops: const [
          0.1,
          0.5,
          0.9,
        ],
        transform: _SlidingGradientTransform(progress),
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) => oldDelegate.progress != progress;
}

class _SlidingGradientTransform extends GradientTransform {
  final double progress;
  const _SlidingGradientTransform(this.progress);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (progress * 2 - 1), 0, 0);
  }
}

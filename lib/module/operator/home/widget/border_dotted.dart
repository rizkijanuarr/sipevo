import 'package:flutter/material.dart';

class BorderDotted extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double gap;

  const BorderDotted({
    super.key,
    required this.child,
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        painter: BorderDottedPainter(
          color: color,
          strokeWidth: strokeWidth,
          dashPattern: dashPattern,
          gap: gap,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class BorderDottedPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double gap;

  BorderDottedPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startX = 0;
    while (startX < size.width) {
      for (int i = 0; i < dashPattern.length; i += 2) {
        final double endX = startX + dashPattern[i];
        if (endX < size.width) {
          canvas.drawLine(Offset(startX, 0), Offset(endX, 0), paint);
        }
        startX = endX + dashPattern[i + 1] + gap;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

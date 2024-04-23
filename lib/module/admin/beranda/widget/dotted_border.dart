import 'package:flutter/material.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;
  final Color color; // Warna garis putus-putus
  final double strokeWidth; // Lebar garis putus-putus
  final List<double> dashPattern; // Pola garis putus-putus
  final double gap; // Jarak antara titik-titik

  const DottedBorder({
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
        painter: DottedBorderPainter(
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

class DottedBorderPainter extends CustomPainter {
  final Color color; // Properti warna
  final double strokeWidth; // Properti lebar garis
  final List<double> dashPattern; // Properti pola garis putus-putus
  final double gap; // Properti jarak antara titik-titik

  DottedBorderPainter({
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
        startX = endX + dashPattern[i + 1] + gap; // Menambahkan gap
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

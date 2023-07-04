import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final double value;

  TrianglePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4.0;

    final y = size.height;
    final x = size.width;

    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    var paintBlack = Paint()
      ..color = const Color(0xff161B31)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path
      ..moveTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y)..lineTo(x / 2, 0);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paintBlack);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

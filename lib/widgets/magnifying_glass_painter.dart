import 'package:flutter/material.dart';

class MagnifyingGlassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Color color = const Color(0xFF58595B);

    double strokeWidth = 5;

    double radius = size.width;

    Offset offset = Offset(radius / 2, radius / 2);

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // ..strokeCap = StrokeCap.round;

    canvas.drawCircle(offset, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

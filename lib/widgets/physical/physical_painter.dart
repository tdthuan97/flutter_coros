import 'dart:math';

import 'package:flutter/material.dart';

class PhysicalPainter extends CustomPainter {
  final double value;

  PhysicalPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4.0;

    var paintBackGround = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    var paintEnergy = Paint()
      ..color = const Color(0xff31C9C9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double widthDash = 0.05;

    var paintDashed = Paint()
      ..color = const Color(0xff161B31)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    // ..strokeCap = StrokeCap.round;

    // canvas.drawCircle(Offset(200, 200), 100, paint1);
    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height - (size.height / 3)),
        width: 120,
        height: 120);

    canvas.drawArc(rect, pi, pi, false, paintBackGround);

    double percent = (pi) * (value);

    canvas.drawArc(rect, pi, percent, false, paintEnergy);

    canvas.drawArc(rect, pi + (pi / 5), widthDash, false, paintDashed);
    canvas.drawArc(rect, pi + 3.2 * (pi / 5), widthDash, false, paintDashed);
    canvas.drawArc(rect, pi + 4.3 * (pi / 5), widthDash, false, paintDashed);
    // canvas.drawArc(rect, (5 * pi) / 4, widthDash , false, paintDashed);
    // canvas.drawArc(rect, pi, pi, false, paintEnergy);
    // canvas.drawArc(rect, pi, pi, false, paintEnergy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

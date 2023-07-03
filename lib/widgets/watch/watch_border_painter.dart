import 'dart:math';

import 'package:flutter/material.dart';

class WatchBorderPainter extends CustomPainter {
  final double value;

  WatchBorderPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    // canvas.drawCircle(Offset(200, 200), 100, paint1);
    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width ,
        height: size.height);

    canvas.drawArc(rect, (3 * pi) / 2, 2 * pi, false, paint1);

    double percent = (2 * pi) * (value);

    canvas.drawArc(rect, (3 * pi) / 2, percent, false, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

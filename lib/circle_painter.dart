import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double value;

  CirclePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xff5C6175)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = const Color(0xffF6C43F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.0
      ..strokeCap = StrokeCap.round;

    // canvas.drawCircle(Offset(200, 200), 100, paint1);
    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width ,
        height: size.height);

    canvas.drawArc(rect, (3 * pi) / 4, (2 * pi) - (pi / 2), false, paint1);

    double percent = ((2 * pi) - (pi / 2)) * (value);

    canvas.drawArc(rect, (3 * pi) / 4, percent, false, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

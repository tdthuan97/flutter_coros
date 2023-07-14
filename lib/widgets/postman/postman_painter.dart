import 'dart:math';

import 'package:flutter/material.dart';

class PostmanPainter extends CustomPainter {
  final double value;

  PostmanPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;

    Color color = const Color(0xffFF9800);

    Offset offsetCenter = Offset(radius, radius);

    double strokeWidth = 2.0;

    double disBetweenCircles = 20;

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    /// list chứa offset 3 hình tròn nhỏ
    List<Offset> listSmallCircles = [];

    double initialDisplacement = offsetCenter.dx;

    /// vẽ 3 đường tròn, từ ngoài vào trong
    for (int i = 0; i <= 2; i++) {
      double radiusOfPath = radius - (i * disBetweenCircles);
      canvas.drawCircle(offsetCenter, radiusOfPath, paint);

      num rotationSpeed = pow(2,i);
      double rotationAngle = value * ((pi) / 180);


      double x = radius +
          radiusOfPath *
              cos(initialDisplacement + rotationAngle  * rotationSpeed);

      double y = radius +
          radiusOfPath *
              sin(initialDisplacement + rotationAngle * rotationSpeed);

      listSmallCircles.add(Offset(
          x, y));
    }

    paint.style = PaintingStyle.fill;

    /// vẽ đường tròn tâm
    canvas.drawCircle(offsetCenter, disBetweenCircles, paint);

    /// vẽ 3 hình tròn nhỏ
    for (Offset offset in listSmallCircles) {
      canvas.drawCircle(offset, 5.0, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

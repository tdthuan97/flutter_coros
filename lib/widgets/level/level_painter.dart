import 'dart:math';

import 'package:flutter/material.dart';

class LevelPainter extends CustomPainter {
  final double value;

  LevelPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5.0;

    double radius = size.width / 2;
    double duongKinh = size.width;

    Offset offsetCenter = Offset(radius, radius);

    var paintOut = Paint()
      ..color = const Color(0xffFF8E00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      //..strokeCap = StrokeCap.butt  // StrokeCap.round is not recommended.
      ..strokeCap = StrokeCap.round;

    var paintIn = Paint()
      // ..color = const Color(0xff1B213A)
      ..color = Colors.grey.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;

    double widthDash = 0.04;

    var paintDashed = Paint()
      ..color = const Color(0xff151B35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Rect rectOut = Rect.fromCenter(
        center: Offset(radius, radius), width: duongKinh, height: duongKinh);
    canvas.drawArc(rectOut, pi, pi, false, paintOut);

    // double percent = (pi) * (_value);

    double distanceBetweenTwoCircle = 50;

    Rect rectIn = Rect.fromCenter(
        center: Offset(radius, radius),
        width: duongKinh - distanceBetweenTwoCircle,
        height: duongKinh - distanceBetweenTwoCircle);
    canvas.drawArc(rectIn, pi, pi, false, paintIn);

    canvas.drawArc(rectOut, pi + (pi / 5) * 1.9, widthDash, false, paintDashed);
    canvas.drawArc(rectOut, pi + (pi / 5) * 2.9, widthDash, false, paintDashed);
    canvas.drawArc(rectOut, pi + (pi / 5) * 3.8, widthDash, false, paintDashed);
    canvas.drawArc(rectOut, pi + (pi / 5) * 4.3, widthDash, false, paintDashed);
    canvas.drawArc(
        rectOut, pi + (pi / 5) * 4.75, widthDash, false, paintDashed);

    double _value = value;

    /// 270 -> 90 =
    double degree = (270 - (1.8 * _value)) * (pi / 180);

    double radiusIn = (size.width / 2) - (distanceBetweenTwoCircle / 2);
    double radiusOut = radiusIn + (distanceBetweenTwoCircle / 2);

    Offset offsetStart = Offset((radiusIn * sin(degree)) + offsetCenter.dx,
        (radiusIn * cos(degree)) + offsetCenter.dx);
    Offset offsetEnd = Offset((radiusOut * sin(degree)) + offsetCenter.dx,
        (radiusOut * cos(degree)) + offsetCenter.dx);

    // double addValuePointLeftRight = 1 - (_value / 100);
    double addValuePointLeftRight = 2;

    double yDistanceTwoPointLeftRight;
    if (_value < 50) {
      yDistanceTwoPointLeftRight = 2;
    } else if (_value > 50) {
      yDistanceTwoPointLeftRight = -2;
    } else {
      yDistanceTwoPointLeftRight = 0;
    }

    double xDistanceTwoPointLeftRight;
    if (_value == 0 || _value == 100) {
      xDistanceTwoPointLeftRight = 0;
    } else {
      xDistanceTwoPointLeftRight = 2;
    }

    final path = Path()
          ..moveTo(offsetStart.dx + xDistanceTwoPointLeftRight,
              offsetStart.dy - yDistanceTwoPointLeftRight) // nút phải
          ..lineTo(offsetEnd.dx, offsetEnd.dy) // điểm nhọn
          ..lineTo(offsetStart.dx - xDistanceTwoPointLeftRight,
              offsetStart.dy + yDistanceTwoPointLeftRight) // nút trái
        // ..lineTo(0, y)..lineTo(x / 2, 0)
        ;

    var paintMini = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paintMini);

    canvas.drawCircle(offsetStart, 2.5, paintMini);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

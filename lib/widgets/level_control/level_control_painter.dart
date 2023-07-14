import 'dart:math';

import 'package:flutter/material.dart';

class LevelControlPainter extends CustomPainter {
  final double value;

  LevelControlPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 5.0;

    double radius = size.width / 2;
    double duongKinh = size.width;

    Offset offsetCenter = Offset(radius, radius);

    var paintOut = Paint()
      // ..color = const Color(0xffFF8E00)
      ..shader = const RadialGradient(colors: [
        Color(0xffFFAF3F),
        Color(0xffFF8F02),
        Color(0xff822A00),
      ], center: Alignment(-0.3, 0.1)
              // center: Alignment(-0.9, 0.5)
              )
          .createShader(Rect.fromCircle(
        center: offsetCenter,
        radius: duongKinh,
        // radius: radius,
      ))
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

    // double _value = value;
    //
    print("value $value");

    /// 270 -> 90 =
    double degree = (270 - (1.8 * value)) * (pi / 180);
    // double degree =
    //     ( (((offsetCenter.dx * offset.dx) + (offsetCenter.dy * offset.dy))
    //             .abs()) /
    //         (sqrt(pow(offsetCenter.dx, 2) + pow(offset.dx, 2)) *
    //             sqrt(pow(offsetCenter.dy, 2) + pow(offset.dy, 2))));
    // print("degree $degree");
    // degree = degree * 100;
    // print("degree $degree");

    double radiusIn = (size.width / 2) - (distanceBetweenTwoCircle / 2);
    double radiusOut = radiusIn + (distanceBetweenTwoCircle / 2);

    var paintMini = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    double disPointCenter = 2 * (pi / 180);

    Offset offsetPointLeft = Offset(
        (radiusIn * sin(degree - disPointCenter)) + offsetCenter.dx,
        (radiusIn * cos(degree - disPointCenter)) + offsetCenter.dx);
    Offset offsetPointCenter = Offset(
        (radiusOut * sin(degree)) + offsetCenter.dx,
        (radiusOut * cos(degree)) + offsetCenter.dx);
    Offset offsetPointRight = Offset(
        (radiusIn * sin(degree + disPointCenter)) + offsetCenter.dx,
        (radiusIn * cos(degree + disPointCenter)) + offsetCenter.dx);

    final path = Path()
          ..moveTo(offsetPointLeft.dx, offsetPointLeft.dy) // nút phải
          ..lineTo(offsetPointCenter.dx, offsetPointCenter.dy) // điểm nhọn
          ..lineTo(offsetPointRight.dx, offsetPointRight.dy) // nút trái
        ;
    canvas.drawPath(path, paintMini);

    Offset offsetPointCenterOfIn = Offset(
        (radiusIn * sin(degree)) + offsetCenter.dx,
        (radiusIn * cos(degree)) + offsetCenter.dx);

    canvas.drawCircle(offsetPointCenterOfIn, 2, paintMini);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

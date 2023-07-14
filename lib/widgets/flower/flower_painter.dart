import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flower_widget.dart';

class FlowerPainter extends CustomPainter {
  final List<LineModel> listLines;
  final int value;

  FlowerPainter(this.value, this.listLines);

  late Timer _timer;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    debugPrint("FlowerPainter");

    double radius = size.width / 2;

    Offset offsetCenter = Offset(radius, radius);

    Color colorCircle = const Color(0xff070D25);

    Paint paintCircle = Paint()
      ..color = colorCircle
      // ..color = Colors.red
      // ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(offsetCenter, radius, paintCircle);

    Color colorLine = const Color(0xffCF7E24);

    Paint paintLine = Paint()
      ..color = colorLine
      ..style = PaintingStyle.fill
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round;

    double _value = -180;

    double radiusStart = (size.width / 2) + 8;
    double radiusEnd = (size.width / 2) + 40;

    // final path = Path()
    //   ..moveTo(offsetPointBottom.dx, offsetPointBottom.dy) // nút dưới
    //   ..lineTo(offsetPointTop.dx, offsetPointTop.dy); // nút trên

    // print("value $value");

    var rng = Random();

    // for (LineModel lineModel in listLines) {
    //   double degree = (-lineModel.value) * ((pi) / 180);
    //
    //   double _radiusEnd = radiusEnd + lineModel.addValue;
    //   // + rng.nextInt(5);
    //
    //   Offset offsetPointBottom = Offset(
    //       (radiusStart * sin(degree)) + offsetCenter.dx,
    //       (radiusStart * cos(degree)) + offsetCenter.dx);
    //   Offset offsetPointTop = Offset(
    //       (_radiusEnd * sin(degree)) + offsetCenter.dx,
    //       (_radiusEnd * cos(degree)) + offsetCenter.dx);
    //
    //   canvas.drawLine(offsetPointBottom, offsetPointTop, paintLine);
    // }

    for (int i = -180; i <= 180; i += 10) {
      double degree = -i * ((pi) / 180);

      double _radiusEnd = radiusEnd + rng.nextInt(8);

      Offset offsetPointBottom = Offset(
          (radiusStart * sin(degree)) + offsetCenter.dx,
          (radiusStart * cos(degree)) + offsetCenter.dx);
      Offset offsetPointTop = Offset(
          (_radiusEnd * sin(degree)) + offsetCenter.dx,
          (_radiusEnd * cos(degree)) + offsetCenter.dx);

      paintLine.shader = ui.Gradient.linear(
        offsetPointBottom,
        offsetPointTop,
        [
          const Color(0xff822A00),
          const Color(0xffFFAF3F),

          // Color(0xffFF8F02),
        ],
      );

      canvas.drawLine(offsetPointBottom, offsetPointTop, paintLine);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

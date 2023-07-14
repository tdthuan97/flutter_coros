import 'package:flutter/material.dart';

class RadarWidget extends StatefulWidget {
  const RadarWidget({Key? key}) : super(key: key);

  @override
  State<RadarWidget> createState() => _RadarWidgetState();
}

class _RadarWidgetState extends State<RadarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.fromRadius(25),
      painter: RadarCirclePainter(),
      child: RotationTransition(
          turns: Tween(begin: 0.0, end: 4.0).animate(_controller),
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                center: FractionalOffset.center,
                colors: <Color>[
                  Colors.transparent,
                  const Color(0xFF34A853).withOpacity(0.6),
                  Colors.transparent,
                ],
                stops: const <double>[0.05, 0.25, 0.1],
              ),
            ),
          )),
    );
  }
}

class RadarCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Color color = const Color(0xFF47A920);

    double strokeWidth = size.width / 100;

    double radius = size.width / 2;

    Offset offset = Offset(radius, radius);

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (int i = 1; i <= 3; i++) {
      if (i == 3) {
        paint.strokeWidth = strokeWidth * 2;
      }
      canvas.drawCircle(offset, ((radius / 3) * i), paint);
    }
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = strokeWidth * 0.75;
    canvas.drawCircle(offset, 3, paint);

    canvas.drawLine(Offset(0, radius), Offset(radius * 2, radius), paint);
    canvas.drawLine(Offset(radius, 0), Offset(radius, radius * 2), paint);

    print("radar");
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

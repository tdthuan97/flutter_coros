import 'package:flutter/material.dart';

import 'level_painter.dart';

class LevelPercentWidget extends StatefulWidget {
  const LevelPercentWidget({Key? key, this.value = 0.0}) : super(key: key);
  final double value;

  @override
  State<LevelPercentWidget> createState() => _LevelPercentWidgetState();
}

class _LevelPercentWidgetState extends State<LevelPercentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.animateTo(widget.value,
          duration: const Duration(milliseconds: 800), curve: Curves.linear);
    });
  }

  @override
  void didUpdateWidget(covariant LevelPercentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      animationController.animateTo(widget.value,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          print("animation.value ${animation.value}");
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // color: Colors.red,
                height: 145,
                width: 210,
                child: Center(
                  child:  Container(
                    // color: Colors.teal,
                    height: 90,
                    width: 190,
                    child: CustomPaint(
                      painter: LevelPainter(100 * animation.value),
                    ),
                  ),
                ),
              ),
              const Positioned(
                  bottom: 0,
                  left: 6,
                  child: Text(
                    "0",
                    style: TextStyle(color: Colors.grey),
                  )),
              const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    "100",
                    style: TextStyle(color: Colors.grey),
                  )),
              Positioned(
                bottom: 10,
                child: Text(
                  (animation.value * 100).toDouble().toStringAsFixed(1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              )
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Text(
              //     (animation.value * 100).toDouble().toStringAsFixed(1),
              //     style: const TextStyle(
              //         color: Colors.white,
              //         fontSize: 36,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          );
        });
  }
}
